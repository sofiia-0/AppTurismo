import UIKit

// Clase que representa la vista de registro en la aplicación
class RegistroView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray6 // Establece un color de fondo moderno y suave para la vista
        setupUI() // Configura los elementos de la interfaz de usuario
    }

    // Configura los elementos de la interfaz de usuario
    func setupUI() {
        // Imagen superior
        let imageView = UIImageView() // Crea una vista de imagen
        imageView.image = UIImage(named: "travel_image") // Establece la imagen a mostrar
        imageView.contentMode = .scaleAspectFill // Ajusta la imagen para llenar el espacio disponible sin distorsión
        imageView.translatesAutoresizingMaskIntoConstraints = false // Usa restricciones de Auto Layout
        view.addSubview(imageView) // Agrega la vista de imagen a la vista principal
        
        // Vista contenedora blanca con fondo degradado
        let containerView = UIView() // Crea una vista contenedora
        containerView.backgroundColor = UIColor.white // Establece el color de fondo de la vista
        containerView.layer.cornerRadius = 30 // Aplica esquinas redondeadas
        containerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor // Configura el color de la sombra
        containerView.layer.shadowOffset = CGSize(width: 0, height: 5) // Configura el desplazamiento de la sombra
        containerView.layer.shadowOpacity = 0.3 // Configura la opacidad de la sombra
        containerView.layer.shadowRadius = 15 // Configura el radio de la sombra
        containerView.translatesAutoresizingMaskIntoConstraints = false // Usa restricciones de Auto Layout
        view.addSubview(containerView) // Agrega la vista contenedora a la vista principal
        
        // Etiqueta de bienvenida
        let welcomeLabel = UILabel() // Crea una etiqueta para el texto de bienvenida
        welcomeLabel.text = "¡Viajá por el mundo\ncon nosotros!" // Establece el texto de la etiqueta
        welcomeLabel.textAlignment = .center // Alinea el texto al centro
        welcomeLabel.numberOfLines = 0 // Permite que la etiqueta tenga múltiples líneas
        welcomeLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold) // Configura la fuente de la etiqueta
        welcomeLabel.textColor = UIColor.black // Establece el color del texto
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false // Usa restricciones de Auto Layout
        containerView.addSubview(welcomeLabel) // Agrega la etiqueta a la vista contenedora
        
        // Subtítulo
        let subtitleLabel = UILabel() // Crea una etiqueta para el subtítulo
        subtitleLabel.text = "Descubrí destinos increíbles y disfrutá de experiencias únicas." // Establece el texto del subtítulo
        subtitleLabel.textAlignment = .center // Alinea el texto al centro
        subtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular) // Configura la fuente del subtítulo
        subtitleLabel.textColor = UIColor.darkGray // Establece el color del texto
        subtitleLabel.numberOfLines = 0 // Permite que la etiqueta tenga múltiples líneas
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false // Usa restricciones de Auto Layout
        containerView.addSubview(subtitleLabel) // Agrega el subtítulo a la vista contenedora
        
        // Campo de texto para email
        let emailTextField = PaddedTextField(padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)) // Crea un campo de texto con relleno
        emailTextField.placeholder = "Correo electrónico" // Establece el texto del marcador de posición
        emailTextField.backgroundColor = UIColor.white // Establece el color de fondo del campo de texto
        emailTextField.layer.cornerRadius = 15 // Aplica esquinas redondeadas al campo de texto
        emailTextField.layer.borderWidth = 1 // Configura el ancho del borde
        emailTextField.layer.borderColor = UIColor.systemGray4.cgColor // Establece el color del borde
        emailTextField.translatesAutoresizingMaskIntoConstraints = false // Usa restricciones de Auto Layout
        containerView.addSubview(emailTextField) // Agrega el campo de texto a la vista contenedora
        
        // Campo de texto para contraseña
        let passwordTextField = PaddedTextField(padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)) // Crea un campo de texto con relleno
        passwordTextField.placeholder = "Contraseña" // Establece el texto del marcador de posición
        passwordTextField.backgroundColor = UIColor.white // Establece el color de fondo del campo de texto
        passwordTextField.layer.cornerRadius = 15 // Aplica esquinas redondeadas al campo de texto
        passwordTextField.layer.borderWidth = 1 // Configura el ancho del borde
        passwordTextField.layer.borderColor = UIColor.systemGray4.cgColor // Establece el color del borde
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false // Usa restricciones de Auto Layout
        passwordTextField.isSecureTextEntry = true // Establece el campo como seguro (oculta el texto)
        containerView.addSubview(passwordTextField) // Agrega el campo de texto a la vista contenedora
        
        // Botón de continuar
        let continueButton = UIButton(type: .system) // Crea un botón del tipo sistema
        continueButton.setTitle("Continuar", for: .normal) // Establece el título del botón
        continueButton.setTitleColor(.white, for: .normal) // Establece el color del texto del botón
        continueButton.backgroundColor = UIColor.black // Establece el color de fondo del botón
        continueButton.layer.cornerRadius = 25 // Aplica esquinas redondeadas al botón
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold) // Configura la fuente del texto del botón
        continueButton.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor // Configura el color de la sombra del botón
        continueButton.layer.shadowOffset = CGSize(width: 0, height: 4) // Configura el desplazamiento de la sombra
        continueButton.layer.shadowOpacity = 0.2 // Configura la opacidad de la sombra
        continueButton.layer.shadowRadius = 6 // Configura el radio de la sombra
        continueButton.translatesAutoresizingMaskIntoConstraints = false // Usa restricciones de Auto Layout
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside) // Añade un objetivo para el evento de toque
        containerView.addSubview(continueButton) // Agrega el botón a la vista contenedora
        
        // Configuración de restricciones de Auto Layout
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), // Establece la distancia desde la parte superior segura
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Centra la imagen horizontalmente
            imageView.widthAnchor.constraint(equalToConstant: 120), // Establece el ancho fijo de la imagen
            imageView.heightAnchor.constraint(equalToConstant: 120), // Establece la altura fija de la imagen
            
            containerView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20), // Establece la distancia desde la parte inferior de la imagen
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // Establece la distancia desde el borde izquierdo de la vista
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // Establece la distancia desde el borde derecho de la vista
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20), // Establece la distancia desde la parte inferior segura
            
            welcomeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20), // Establece la distancia desde la parte superior de la vista contenedora
            welcomeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20), // Establece la distancia desde el borde izquierdo de la vista contenedora
            welcomeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20), // Establece la distancia desde el borde derecho de la vista contenedora
            
            subtitleLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 15), // Establece la distancia desde la parte inferior de la etiqueta de bienvenida
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20), // Establece la distancia desde el borde izquierdo de la vista contenedora
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20), // Establece la distancia desde el borde derecho de la vista contenedora
            
            emailTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20), // Establece la distancia desde la parte inferior del subtítulo
            emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20), // Establece la distancia desde el borde izquierdo de la vista contenedora
            emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20), // Establece la distancia desde el borde derecho de la vista contenedora
            emailTextField.heightAnchor.constraint(equalToConstant: 50), // Establece la altura fija del campo de texto
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15), // Establece la distancia desde la parte inferior del campo de texto de email
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20), // Establece la distancia desde el borde izquierdo de la vista contenedora
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20), // Establece la distancia desde el borde derecho de la vista contenedora
            passwordTextField.heightAnchor.constraint(equalToConstant: 50), // Establece la altura fija del campo de texto
            
            continueButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor), // Centra el botón horizontalmente en la vista contenedora
            continueButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20), // Establece la distancia desde la parte inferior del campo de texto de contraseña
            continueButton.widthAnchor.constraint(equalToConstant: 200), // Establece el ancho fijo del botón
            continueButton.heightAnchor.constraint(equalToConstant: 50) // Establece la altura fija del botón
        ])
    }
    
    // Acción para el botón de continuar
    @objc func continueButtonTapped() {
        let homeView = HomeView() // Crea una instancia de la vista de inicio
        navigationController?.pushViewController(homeView, animated: true) // Navega a la vista de inicio con una animación
    }
}

// Clase personalizada para un campo de texto con relleno
class PaddedTextField: UITextField {

    var padding: UIEdgeInsets // Relleno personalizado para el campo de texto

    // Inicializador con relleno personalizado
    init(padding: UIEdgeInsets) {
        self.padding = padding
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        self.padding = .zero // Relleno por defecto si se usa un inicializador de codificación
        super.init(coder: coder)
    }

    // Ajusta el área de texto para que respete el relleno
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // Ajusta el área de edición para que respete el relleno
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // Ajusta el área del marcador de posición para que respete el relleno
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
