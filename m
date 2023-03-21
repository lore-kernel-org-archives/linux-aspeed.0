From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 21 Mar 2023 16:19:33 +0100
Subject: [PATCH v2 2/4] doc: Add Atmel AT30TSE serial eeprom
In-Reply-To: <20230321151642.461618-3-eajames@linux.ibm.com>
References: <20230321151642.461618-1-eajames@linux.ibm.com>
 <20230321151642.461618-3-eajames@linux.ibm.com>
Message-ID: <6d4cf513-0787-6b39-8d38-30484be7ddff@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/03/2023 16:16, Eddie James wrote:
> The AT30TSE is compatible with the JEDEC EE1004 standard. Document it
> as a trivial I2C device.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 6f482a254a1d..43e26c73a95f 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -47,6 +47,8 @@ properties:
>            - ams,iaq-core
>              # i2c serial eeprom (24cxx)
>            - at,24c08
> +            # i2c serial eeprom (EE1004 standard)

AT30TSE?

> +          - atmel,at30tse

Microchip does not find anything on AT30TSE. Are you sure this is the
model name?


Best regards,
Krzysztof

