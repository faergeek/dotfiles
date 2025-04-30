;; extends

(item_extension
  (attribute_id) @_name
  (#eq? @_name "mel.raw")
  (attribute_payload
    (expression_item
      (quoted_string
        (quoted_string_content) @injection.content)))
  (#set! injection.language "javascript"))

(item_extension
  (attribute_id) @_name
  (#eq? @_name "mel.raw")
  (attribute_payload
    (expression_item
      (string
        (string_content) @injection.content)))
  (#set! injection.language "javascript"))

(extension
  (attribute_id) @_name
  (#eq? @_name "mel.raw")
  (attribute_payload
    (expression_item
      (quoted_string
        (quoted_string_content) @injection.content)))
  (#set! injection.language "javascript"))

(extension
  (attribute_id) @_name
  (#eq? @_name "mel.raw")
  (attribute_payload
    (expression_item
      (string
        (string_content) @injection.content)))
  (#set! injection.language "javascript"))
