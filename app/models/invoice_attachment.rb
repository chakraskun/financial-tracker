class InvoiceAttachment < ApplicationRecord
  has_one_attached :proof_of_transaction, service: :s3

  validate :acceptable_image

  def acceptable_image
    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(proof_of_transaction.content_type)
      errors.add(:proof_of_transaction, "must be a JPEG or PNG")
    end
  end
end
