## Credit https://github.com/jonnyzzz

locals {
    wafs = [
        { type = "IPV4", value = "72.21.196.64/32"},
        { type = "IPV4", value = "204.246.162.42/32"}
    ]
}

resource "null_resource" "ipv4" {
    count = "${length(local.wafs)}"

    triggers {

        cidr = "${
        lookup(local.wafs[count.index], "type") == "IPV4"
        ? lookup(local.wafs[count.index], "value")
        : ""
        }"
    }
}

output "cidr" {
    value = ["${compact(null_resource.ipv4.*.triggers.cidr)}"]
}

output "waf" {
    value = ["${local.wafs}"]
}
