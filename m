From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Oct 2023 12:18:01 +1030
Subject: [PATCH 1/7] ARM: dts: aspeed: mtjade, mtmitchell: Update gpio-line-names
In-Reply-To: <20231005035525.19036-2-chanh@os.amperecomputing.com>
References: <20231005035525.19036-1-chanh@os.amperecomputing.com> <20231005035525.19036-2-chanh@os.amperecomputing.com>
Message-ID: <CACPK8XdpUpg0vDG7UwO-o=dYD-88evizSUb-yKm9qdUP2rjzdg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 at 14:26, Chanh Nguyen <chanh@os.amperecomputing.com> wrote:
>
> Update GPIO line-name to follow naming convention specified at
> github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   | 42 +++++++++----------
>  .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   |  6 +--
>  2 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> index 0a51d2e32fab..e57efcc8522a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> @@ -760,30 +760,30 @@
>
>  &gpio {
>         gpio-line-names =
> -       /*A0-A7*/       "","","","S0_BMC_SPECIAL_BOOT","","","","",
> -       /*B0-B7*/       "BMC_SELECT_EEPROM","","","",
> -                       "POWER_BUTTON","","","",
> +       /*A0-A7*/       "","","","host0-special-boot","","","","",
> +       /*B0-B7*/       "i2c-backup-sel","","","",
> +                       "power-button","","","",
>         /*C0-C7*/       "","","","","","","","",
>         /*D0-D7*/       "","","","","","","","",
>         /*E0-E7*/       "","","","","","","","",
> -       /*F0-F7*/       "","","BMC_SYS_PSON_L","S0_DDR_SAVE","PGOOD",
> -                       "S1_DDR_SAVE","","",
> -       /*G0-G7*/       "host0-ready","SHD_REQ_L","","S0_OVERTEMP_L","","",
> +       /*F0-F7*/       "","","power-chassis-control","s0-ddr-save","power-chassis-good",
> +                       "s1-ddr-save","","",
> +       /*G0-G7*/       "host0-ready","host0-shd-req-n","","s0-overtemp-n","","",
>                         "","",
> -       /*H0-H7*/       "","","","","PSU1_VIN_GOOD","PSU2_VIN_GOOD","","",
> -       /*I0-I7*/       "PSU1_PRESENT","PSU2_PRESENT","S1_BMC_SPECIAL_BOOT",
> -                       "","","","","",
> -       /*J0-J7*/       "S0_HIGHTEMP_L","S0_FAULT_L","S0_SCP_AUTH_FAIL_L","",
> +       /*H0-H7*/       "","","","","ps0-vin-good","ps1-vin-good","","",
> +       /*I0-I7*/       "presence-ps0","presence-ps1","s1-special-boot",
> +                               "","","","","",
> +       /*J0-J7*/       "s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n","",
>                         "","","","",
>         /*K0-K7*/       "","","","","","","","",
> -       /*L0-L7*/       "","","","BMC_SYSRESET_L","SPI_AUTH_FAIL_L","","","",
> +       /*L0-L7*/       "","","","host0-sysreset-n","s0-spi-auth-fail-n","","","",
>         /*M0-M7*/       "","","","","","","","",
>         /*N0-N7*/       "","","","","","","","",
>         /*O0-O7*/       "","","","","","","","",
>         /*P0-P7*/       "","","","","","","","",
> -       /*Q0-Q7*/       "","","","","","UID_BUTTON","","",
> -       /*R0-R7*/       "","","BMC_EXT_HIGHTEMP_L","OCP_AUX_PWREN",
> -                       "OCP_MAIN_PWREN","RESET_BUTTON","","",
> +       /*Q0-Q7*/       "","","","","","identify-button","","",
> +       /*R0-R7*/       "","","ext-hightemp-n","",
> +                       "ocp-main-pwren","reset-button","","",
>         /*S0-S7*/       "","","","","rtc-battery-voltage-read-enable","","","",
>         /*T0-T7*/       "","","","","","","","",
>         /*U0-U7*/       "","","","","","","","",
> @@ -791,18 +791,18 @@
>         /*W0-W7*/       "","","","","","","","",
>         /*X0-X7*/       "","","","","","","","",
>         /*Y0-Y7*/       "","","","","","","","",
> -       /*Z0-Z7*/       "S0_BMC_PLIMIT","S1_FAULT_L","S1_FW_BOOT_OK","","",
> -                       "S1_SCP_AUTH_FAIL_L","S1_OVERTEMP_L","",
> +       /*Z0-Z7*/       "s0-plimit","s1-fault-alert","s1-fw-boot-ok","","",
> +                       "s1-sys-auth-failure-n","s1-overtemp-n","",
>         /*AA0-AA7*/     "","","","","","","","",
> -       /*AB0-AB7*/     "S1_HIGHTEMP_L","S1_BMC_PLIMIT","S0_BMC_DDR_ADDR",
> -                       "S1_BMC_DDR_ADR","","","","",
> -       /*AC0-AC7*/     "SYS_PWR_GD","","","","","BMC_READY","SLAVE_PRESENT_L",
> -                       "BMC_OCP_PG";
> +       /*AB0-AB7*/     "s1-hightemp-n","s1-plimit","s0-ddr-addr",
> +                       "s1-ddr-addr","","","","",
> +       /*AC0-AC7*/     "sys-pwr-gd","","","","","","presence-cpu1",
> +                       "ocp-pgood";
>
>         i2c4-o-en-hog {
>                 gpio-hog;
>                 gpios = <ASPEED_GPIO(Y, 2) GPIO_ACTIVE_HIGH>;
>                 output-high;
> -               line-name = "BMC_I2C4_O_EN";
> +               line-name = "i2c4-o-en";
>         };
>  };
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> index 0715cb9ab30c..2f571b43106d 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> @@ -599,17 +599,17 @@
>         /*Q0-Q7*/       "","","","","","","","",
>         /*R0-R7*/       "","","","","","","","",
>         /*S0-S7*/       "","","identify-button","led-identify",
> -                       "s1-ddr-save","spi-nor-access","sys-pgood","presence-cpu1",
> +                       "s1-ddr-save","spi-nor-access","host0-ready","presence-cpu1",
>         /*T0-T7*/       "","","","","","","","",
>         /*U0-U7*/       "","","","","","","","",
>         /*V0-V7*/       "s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
> -                       "host0-reboot-ack-n","host0-ready","host0-shd-req-n",
> +                       "host0-reboot-ack-n","s0-fw-boot-ok","host0-shd-req-n",
>                         "host0-shd-ack-n","s0-overtemp-n",
>         /*W0-W7*/       "","ocp-main-pwren","ocp-pgood","",
>                         "bmc-ok","bmc-ready","spi0-program-sel","spi0-backup-sel",
>         /*X0-X7*/       "i2c-backup-sel","s1-fault-alert","s1-fw-boot-ok",
>                         "s1-hightemp-n","s0-spi-auth-fail-n","s1-sys-auth-failure-n",
> -                       "s1-overtemp-n","s1-spi-auth-fail-n",
> +                       "s1-overtemp-n","cpld-s1-spi-auth-fail-n",
>         /*Y0-Y7*/       "","","","","","","","host0-special-boot",
>         /*Z0-Z7*/       "reset-button","ps0-pgood","ps1-pgood","","","","","";
>
> --
> 2.17.1
>
