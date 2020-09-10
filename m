From: Nishanth Menon <nm@ti.com>
Date: Thu, 10 Sep 2020 13:28:14 -0500
Subject: [PATCH v2 01/15] dt-bindings: gpio: convert bindings for NXP
 PCA953x family to dtschema
In-Reply-To: <20200910175733.11046-2-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-2-krzk@kernel.org>
Message-ID: <20200910182814.veviax3n377undkv@akan>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 19:57-20200910, Krzysztof Kozlowski wrote:
[...]
> +  wakeup-source:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +patternProperties:
> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":

I wonder if "hog" is too generic and might clash with "something-hog" in
the future?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
