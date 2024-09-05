import UIKit

// Definición de la clase InicioView que hereda de UIViewController
class InicioView: UIViewController {

    // Método llamado cuando la vista ha sido cargada en memoria
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Establece el color de fondo de la vista principal como blanco
        view.backgroundColor = .white
        
        // Crea un contenedor para la vista superior que contendrá la imagen de fondo
        let imageViewContainer = UIView()
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        view.addSubview(imageViewContainer)  // Añade el contenedor a la vista principal
        
        // Crea una UIImageView para mostrar la imagen de fondo
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "inicio.png")  // Establece la imagen a mostrar
        backgroundImageView.contentMode = .scaleAspectFill  // Ajusta la imagen para llenar el contenedor sin distorsionarse
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        imageViewContainer.addSubview(backgroundImageView)  // Añade la imagen al contenedor
        
        // Crea una vista inferior blanca que contendrá el contenido principal
        let contentView = UIView()
        contentView.backgroundColor = .white  // Establece el color de fondo como blanco
        contentView.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        view.addSubview(contentView)  // Añade la vista blanca a la vista principal
        
        // Crea una etiqueta para mostrar el logo de Healing
        let logoLabel = UILabel()
        logoLabel.text = "turismo"  // Establece el texto del logo
        logoLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)  // Configura el tamaño y el peso de la fuente
        logoLabel.textColor = .white  // Establece el color del texto como blanco
        logoLabel.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        imageViewContainer.addSubview(logoLabel)  // Añade el logo al contenedor de imagen
        
        // Crea una etiqueta para el título
        let titleLabel = UILabel()
        titleLabel.text = "Explorá tu viaje con nosotros"  // Establece el texto del título
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)  // Configura el tamaño y el peso de la fuente
        titleLabel.textColor = .black  // Establece el color del texto como negro
        titleLabel.textAlignment = .center  // Centra el texto
        titleLabel.numberOfLines = 0  // Permite que el texto ocupe varias líneas si es necesario
        titleLabel.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        contentView.addSubview(titleLabel)  // Añade el título a la vista blanca
        
        // Crea una etiqueta para el subtítulo
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Todos tus destinos de vacaciones están aquí, disfrutá de tus días libres."  // Establece el texto del subtítulo
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)  // Configura el tamaño y el peso de la fuente
        subtitleLabel.textColor = .gray  // Establece el color del texto como gris
        subtitleLabel.textAlignment = .center  // Centra el texto
        subtitleLabel.numberOfLines = 0  // Permite que el texto ocupe varias líneas si es necesario
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        contentView.addSubview(subtitleLabel)  // Añade el subtítulo a la vista blanca
        
        // Crea un botón para comenzar
        let getStartedButton = UIButton(type: .system)
        getStartedButton.setTitle("Comenzar", for: .normal)  // Establece el texto del botón
        getStartedButton.setTitleColor(.white, for: .normal)  // Establece el color del texto del botón como blanco
        getStartedButton.backgroundColor = .black  // Establece el color de fondo del botón como negro
        getStartedButton.layer.cornerRadius = 25  // Establece el radio de las esquinas del botón para hacerlo redondeado
        getStartedButton.layer.shadowColor = UIColor.black.cgColor  // Establece el color de la sombra del botón
        getStartedButton.layer.shadowOffset = CGSize(width: 0, height: 4)  // Establece el desplazamiento de la sombra
        getStartedButton.layer.shadowOpacity = 0.2  // Establece la opacidad de la sombra
        getStartedButton.layer.shadowRadius = 4  // Establece el radio de difuminado de la sombra
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false  // Permite usar Auto Layout
        contentView.addSubview(getStartedButton)  // Añade el botón a la vista blanca
        
        // Asocia una acción al botón para que navegue a la vista de registro cuando se toque
        getStartedButton.addTarget(self, action: #selector(navigateToRegistroView), for: .touchUpInside)
        
        // Configuración de las restricciones de Auto Layout
        NSLayoutConstraint.activate([
            // Restricciones para la vista superior
            imageViewContainer.topAnchor.constraint(equalTo: view.topAnchor),
            imageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageViewContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            // Restricciones para la imagen de fondo dentro de la vista superior
            backgroundImageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor),
            
            // Restricciones para el logo dentro de la vista superior
            logoLabel.topAnchor.constraint(equalTo: imageViewContainer.topAnchor, constant: 20),
            logoLabel.centerXAnchor.constraint(equalTo: imageViewContainer.centerXAnchor),
            
            // Restricciones para la vista inferior blanca
            contentView.topAnchor.constraint(equalTo: imageViewContainer.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Restricciones para el título dentro de la vista blanca
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -40),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // Restricciones para el subtítulo dentro de la vista blanca
            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // Restricciones para el botón dentro de la vista blanca
            getStartedButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            getStartedButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            getStartedButton.widthAnchor.constraint(equalToConstant: 200),
            getStartedButton.heightAnchor.constraint(equalToConstant: 50)
        ])

    }
    
    // Método que se llama cuando el botón es tocado
    @objc func navigateToRegistroView() {
        // Crea una nueva instancia de RegistroView
        let registroView = RegistroView()
        // Navega a la vista de registro
        navigationController?.pushViewController(registroView, animated: true)
    }
}
