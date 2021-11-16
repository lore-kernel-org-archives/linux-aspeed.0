From: Joel Stanley <joel@jms.id.au>
Date: Tue, 16 Nov 2021 03:07:48 +0000
Subject: [PATCH v2] ARM: dts: aspeed: Adding Facebook Bletchley BMC
In-Reply-To: <20211110062656.3041994-1-howard.chiu@quantatw.com>
References: <20211110062656.3041994-1-howard.chiu@quantatw.com>
Message-ID: <CACPK8Xc6wV4KbMAT_ekyMTTbfNqx2ox_d7mEFGVT4OvBDDadBQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Howard,

On Wed, 10 Nov 2021 at 06:29, Howard Chiu <howard10703049@gmail.com> wrote:
>
> Initial introduction of Facebook Bletchley equipped with
> Aspeed 2600 BMC SoC.
>
> Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>
> ---

Please use this area to document the differences between versions of
your patch. Let us know what you've fixed, and what you've decided not
to change based on review.

> +&uart5 {
> +       // Workaround for A0
> +       compatible = "snps,dw-apb-uart";
> +};

Are you still using a0 boards?

> +
> +&i2c0 {
> +       status = "okay";
> +       /* TODO: Add HSC MP5023 */
> +       /* TODO: Add ADC INA230 */
> +
> +       tmp421 at 4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +
> +       sled0_ioexp: pca9539 at 76 {
> +               compatible = "nxp,pca9539";
> +               reg = <0x76>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "","SLED0_BMC_CCG5_INT","SLED0_INA230_ALERT","SLED0_P12V_STBY_ALERT",
> +               "SLED0_SSD_ALERT","SLED0_MS_DETECT","SLED0_MD_REF_PWM","",
> +               "SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_MD_DECAY",
> +               "SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","SLED0_AC_PWR_EN";

I'll wait for Patrick's review on these. I would prefer you follow the
openbmc naming scheme that he mentioned in v1 of your patch.

> +
> +               gpio at 0 {
> +                       reg = <0>;
> +               };

I think this is incorrect, you would need to specify:

type = <PCA955X_TYPE_GPIO>

However with this change, there's no need to specify the individual gpio nodes:

https://lore.kernel.org/all/20210921043936.468001-2-andrew at aj.id.au/


> +
> +&i2c4 {
> +       status = "okay";
> +       /* TODO: Add HSC MP5023 */
> +       /* TODO: Add ADC INA230 */
> +
> +       tmp421 at 4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +
> +       sled4_ioexp: pca9539 at 76 {
> +               compatible = "nxp,pca9539";
> +               reg = <0x76>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "","SLED4_BMC_CCG5_INT","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
> +               "SLED4_SSD_ALERT","SLED4_MS_DETECT","SLED4_MD_REF_PWM","",
> +               "SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
> +               "SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","SLED4_AC_PWR_EN";

As Patrick mentioned, I think we want to have a convention for
multi-node machines in the GPIO naming.
