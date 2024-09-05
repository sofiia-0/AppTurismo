import UIKit
import MapKit

// Definición de la clase HomeView que hereda de UIViewController y adopta varios protocolos para gestionar vistas y mapas
class HomeView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MKMapViewDelegate, CLLocationManagerDelegate {

    // Vista de desplazamiento que contendrá todo el contenido de la vista principal
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        return scrollView
    }()

    // Vista contenedora para el contenido dentro del scrollView
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        return view
    }()

    // Etiqueta para mostrar un saludo
    let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Good Morning,"  // Establece el texto de saludo
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)  // Configura el tamaño y el peso de la fuente
        label.textColor = .black  // Establece el color del texto como negro
        label.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        return label
    }()

    // Vista que muestra la ubicación actual del usuario
    let locationContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6  // Establece el color de fondo
        view.layer.cornerRadius = 12  // Redondea las esquinas
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor  // Configura el color de la sombra
        view.layer.shadowOffset = CGSize(width: 0, height: 2)  // Configura el desplazamiento de la sombra
        view.layer.shadowOpacity = 1  // Establece la opacidad de la sombra
        view.layer.shadowRadius = 8  // Establece el radio de difuminado de la sombra
        view.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        return view
    }()

    // Etiqueta que muestra el texto "Tu ubicación"
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Tu ubicación"  // Establece el texto
        label.textColor = .systemBlue  // Establece el color del texto como azul
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)  // Configura el tamaño y el peso de la fuente
        label.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        return label
    }()

    // Etiqueta que muestra la ubicación actual del usuario
    let locationSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Managua, Nicaragua"  // Establece el texto
        label.textColor = .systemGray  // Establece el color del texto como gris
        label.font = UIFont.systemFont(ofSize: 14)  // Configura el tamaño de la fuente
        label.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        return label
    }()

    // Vista del mapa que muestra la ubicación del usuario
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        mapView.layer.cornerRadius = 12  // Redondea las esquinas del mapa
        mapView.layer.masksToBounds = true  // Asegura que el mapa no se desborde fuera de sus bordes redondeados
        return mapView
    }()

    // Vista de pila para los botones de categoría
    let categoriesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal  // Configura la dirección de la pila como horizontal
        stackView.alignment = .center  // Alinea los elementos al centro
        stackView.distribution = .fillEqually  // Distribuye los elementos equitativamente
        stackView.spacing = 12  // Espaciado entre los elementos
        stackView.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        return stackView
    }()

    // Títulos y iconos para los botones de categoría
    let categoryTitles = ["Beach", "Mountain", "Desert"]
    let categoryIcons = ["🏖️", "🏔️", "🌴"]

    // Etiqueta para la sección de recomendaciones
    let recommendationLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommendation"  // Establece el texto de la etiqueta
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)  // Configura el tamaño y el peso de la fuente
        label.textColor = .black  // Establece el color del texto como negro
        label.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        return label
    }()

    // Colección para mostrar las recomendaciones
    let recommendationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal  // Configura la dirección de desplazamiento como horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear  // Establece el color de fondo como transparente
        collectionView.showsHorizontalScrollIndicator = false  // Oculta el indicador de desplazamiento horizontal
        collectionView.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        return collectionView
    }()

    // Datos de ejemplo para las recomendaciones
    let recommendations = [
        ("italia", "Rome, Italy", "4.7", "Descubre la historia antigua y la cultura vibrante de Roma."),
        ("venecia", "Venice, Italy", "4.9", "Navega por los canales románticos de Venecia."),
        ("francia", "Paris, France", "4.8", "Admira la Torre Eiffel y disfruta de la gastronomía parisina."),
        ("uruguay", "Montevideo, Uruguay", "4.5", "Explora la playa de Montevideo y su rica cultura."),
        ("korea", "Seoul, Korea", "4.6", "Sumérgete en la moderna metrópoli de Seúl y su historia.")
    ]


    // Método llamado cuando la vista ha sido cargada en memoria
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white  // Establece el color de fondo de la vista principal

        setupScrollView()  // Configura la vista de desplazamiento
        setupHeader()  // Configura la sección de saludo y ubicación
        setupCategoryButtons()  // Configura los botones de categorías
        setupRecommendationSection()  // Configura la sección de recomendaciones

        // Configura el mapa y la localización del usuario
        mapView.delegate = self  // Establece el delegado del mapa
        setupMapView()  // Configura el mapa
    }

    // Configura la vista de desplazamiento y su contenido
    func setupScrollView() {
        view.addSubview(scrollView)  // Añade la vista de desplazamiento a la vista principal
        scrollView.addSubview(contentView)  // Añade la vista de contenido al scrollView

        // Establece las restricciones de Auto Layout
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        ])
    }

    // Configura la sección de saludo y ubicación
    func setupHeader() {
        contentView.addSubview(greetingLabel)  // Añade la etiqueta de saludo a la vista de contenido
        contentView.addSubview(locationContainerView)  // Añade la vista de ubicación a la vista de contenido

        // Crea y configura una vista de pila vertical para las etiquetas de ubicación
        let stackView = UIStackView(arrangedSubviews: [locationLabel, locationSubtitleLabel])
        stackView.axis = .vertical  // Configura la dirección de la pila como vertical
        stackView.spacing = 4  // Espaciado entre las etiquetas
        stackView.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        locationContainerView.addSubview(stackView)  // Añade la vista de pila a la vista de ubicación
        locationContainerView.addSubview(mapView)  // Añade el mapa a la vista de ubicación

        // Establece las restricciones de Auto Layout para los elementos
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            greetingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            greetingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            locationContainerView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 16),
            locationContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            locationContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            stackView.topAnchor.constraint(equalTo: locationContainerView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: locationContainerView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: locationContainerView.trailingAnchor, constant: -12),

            mapView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            mapView.leadingAnchor.constraint(equalTo: locationContainerView.leadingAnchor, constant: 12),
            mapView.trailingAnchor.constraint(equalTo: locationContainerView.trailingAnchor, constant: -12),
            mapView.bottomAnchor.constraint(equalTo: locationContainerView.bottomAnchor, constant: -12),
            mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 0.75)
        ])
    }

    // Configura los botones de categorías
    func setupCategoryButtons() {
        for i in 0..<categoryTitles.count {
            let button = UIButton()
            button.setTitle("\(categoryIcons[i]) \(categoryTitles[i])", for: .normal)  // Establece el título del botón con icono y texto
            button.setTitleColor(.black, for: .normal)  // Establece el color del texto del botón
            button.backgroundColor = UIColor.systemGray5  // Establece el color de fondo del botón
            button.layer.cornerRadius = 12  // Redondea las esquinas del botón
            button.layer.borderColor = UIColor.systemGray4.cgColor  // Establece el color del borde del botón
            button.layer.borderWidth = 1  // Establece el ancho del borde del botón
            button.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor  // Configura el color de la sombra
            button.layer.shadowOffset = CGSize(width: 0, height: 2)  // Configura el desplazamiento de la sombra
            button.layer.shadowOpacity = 0.3  // Establece la opacidad de la sombra
            button.layer.shadowRadius = 4  // Establece el radio de difuminado de la sombra
            categoriesStackView.addArrangedSubview(button)  // Añade el botón a la pila de categorías
        }

        contentView.addSubview(categoriesStackView)  // Añade la pila de categorías a la vista de contenido

        // Establece las restricciones de Auto Layout para la pila de categorías
        NSLayoutConstraint.activate([
            categoriesStackView.topAnchor.constraint(equalTo: locationContainerView.bottomAnchor, constant: 24),
            categoriesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoriesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            categoriesStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // Configura la sección de recomendaciones
    func setupRecommendationSection() {
        contentView.addSubview(recommendationLabel)  // Añade la etiqueta de recomendaciones a la vista de contenido
        recommendationCollectionView.delegate = self  // Establece el delegado de la colección
        recommendationCollectionView.dataSource = self  // Establece la fuente de datos de la colección
        recommendationCollectionView.register(RecommendationCell.self, forCellWithReuseIdentifier: "cell")  // Registra la celda personalizada
        contentView.addSubview(recommendationCollectionView)  // Añade la colección de recomendaciones a la vista de contenido

        // Configura el diseño de la colección con relleno
        if let layout = recommendationCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)  // Establece el relleno de la sección
            layout.minimumLineSpacing = 16  // Establece el espaciado mínimo entre líneas
            layout.minimumInteritemSpacing = 16  // Establece el espaciado mínimo entre elementos
        }

        // Establece las restricciones de Auto Layout para la etiqueta de recomendaciones y la colección
        NSLayoutConstraint.activate([
            recommendationLabel.topAnchor.constraint(equalTo: categoriesStackView.bottomAnchor, constant: 24),
            recommendationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recommendationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            recommendationCollectionView.topAnchor.constraint(equalTo: recommendationLabel.bottomAnchor, constant: 16),
            recommendationCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recommendationCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recommendationCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            recommendationCollectionView.heightAnchor.constraint(equalToConstant: 270)
        ])
    }

    // Configura el mapa y la autorización para usar la ubicación
    func setupMapView() {
        if CLLocationManager.locationServicesEnabled() {
            let locationManager = CLLocationManager()
            locationManager.delegate = self  // Establece el delegado del administrador de ubicación
            locationManager.requestWhenInUseAuthorization()  // Solicita autorización para usar la ubicación mientras se usa la aplicación
            mapView.showsUserLocation = true  // Muestra la ubicación del usuario en el mapa
            mapView.userTrackingMode = .follow  // Configura el modo de seguimiento de la ubicación del usuario
        }
    }

    // MARK: - UICollectionViewDelegate y DataSource

    // Devuelve el número de elementos en la colección
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendations.count  // Devuelve la cantidad de recomendaciones
    }

    // Configura la celda para un índice específico
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recommendationCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecommendationCell
            let recommendation = recommendations[indexPath.item]
            cell.imageView.image = UIImage(named: recommendation.0)  // Establece la imagen de la celda
            cell.titleLabel.text = recommendation.1  // Establece el título de la celda
            cell.subtitleLabel.text = recommendation.1  // Establece el subtítulo de la celda
            cell.ratingLabel.text = recommendation.2  // Establece la calificación de la celda
            
            // Añade la descripción específica para cada lugar
            cell.descriptionLabel.text = recommendation.3
            
            return cell
        } else {
            fatalError("Unexpected collection view")  // Maneja un caso inesperado
        }
    }


    // Configura el tamaño de la celda en la colección
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Ajusta el tamaño de la celda según el contenido de la descripción
        let width = collectionView.bounds.width  // Ajusta el ancho de la celda
        let height: CGFloat = 270  // Ajusta la altura de la celda según sea necesario
        return CGSize(width: width, height: height)
    }


    // Configura el espaciado mínimo entre las líneas en la colección
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16  // Establece el espaciado entre las celdas
    }
}

// MARK: - RecommendationCell
// Clase personalizada para las celdas de recomendaciones
class RecommendationCell: UICollectionViewCell {
    
    // Imagen dentro de la celda
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Etiqueta para el título dentro de la celda
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Etiqueta para el subtítulo dentro de la celda
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Etiqueta para la calificación dentro de la celda
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Nueva etiqueta para la descripción
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0  // Permite múltiples líneas sin límite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Inicializador de la celda
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(descriptionLabel)

        // Establece las restricciones de Auto Layout para los subcomponentes
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            ratingLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            descriptionLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
