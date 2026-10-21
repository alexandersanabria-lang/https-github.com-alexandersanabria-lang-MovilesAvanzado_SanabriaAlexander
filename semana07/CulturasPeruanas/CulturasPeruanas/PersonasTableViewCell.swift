import UIKit

class PersonasTableViewCell: UITableViewCell {

    @IBOutlet weak var PersonaImage: UIImageView!
    @IBOutlet weak var personaNombre: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
