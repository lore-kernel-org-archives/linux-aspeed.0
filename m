From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 31 Jan 2020 18:22:32 +0000
Subject: [PATCH v2] ARM: dts: aspeed: tiogapass: Add gpio line names
In-Reply-To: <CACPK8XfJYVH6EotMQcuuoV5hWnkA79oHSCvQBx5gr4np8Y59og@mail.gmail.com>
References: <20200128011817.4095682-1-vijaykhemka@fb.com>
 <CACPK8XfJYVH6EotMQcuuoV5hWnkA79oHSCvQBx5gr4np8Y59og@mail.gmail.com>
Message-ID: <F16856EF-B7AD-461B-9416-B389DEF1FD2D@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 1/30/20, 7:58 PM, "Joel Stanley" <joel@jms.id.au> wrote:

    On Tue, 28 Jan 2020 at 01:18, Vijay Khemka <vijaykhemka@fb.com> wrote:
    >
    > Added GPIO line names for all gpio used in tiogapass platform,
    > these line names will be used by libgpiod to control GPIOs
    >
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    
    The verbosity of the bindings is unfortunate, but I think it's the
    only option we have to date.
    
    Reviewed-by: Joel Stanley <joel@jms.id.au>
    
    I will merge this through the aspeed tree for 5.7.
Thanks Joel.
    
    Cheers,
    
    Joel
    
    > ---
    > v2 : Added BIOS_SPI_BMC_CTRL gpio line name
    >
    >  .../dts/aspeed-bmc-facebook-tiogapass.dts     | 63 +++++++++++++++++++
    >  1 file changed, 63 insertions(+)
    >
    > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    > index 682f729ea25e..fb7f034d5db2 100644
    > --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    > @@ -121,6 +121,69 @@
    >         kcs_addr = <0xca2>;
    >  };
    >
    > +&gpio {
    > +       status = "okay";
    > +       gpio-line-names =
    > +       /*A0-A7*/       "BMC_CPLD_FPGA_SEL","","","","","","","",
    > +       /*B0-B7*/       "","BMC_DEBUG_EN","","","","BMC_PPIN","PS_PWROK",
    > +                       "IRQ_PVDDQ_GHJ_VRHOT_LVT3",
    > +       /*C0-C7*/       "","","","","","","","",
    > +       /*D0-D7*/       "BIOS_MRC_DEBUG_MSG_DIS","BOARD_REV_ID0","",
    > +                       "BOARD_REV_ID1","IRQ_DIMM_SAVE_LVT3","BOARD_REV_ID2",
    > +                       "CPU_ERR0_LVT3_BMC","CPU_ERR1_LVT3_BMC",
    > +       /*E0-E7*/       "RESET_BUTTON","RESET_OUT","POWER_BUTTON",
    > +                       "POWER_OUT","NMI_BUTTON","","CPU0_PROCHOT_LVT3_ BMC",
    > +                       "CPU1_PROCHOT_LVT3_ BMC",
    > +       /*F0-F7*/       "IRQ_PVDDQ_ABC_VRHOT_LVT3","",
    > +                       "IRQ_PVCCIN_CPU0_VRHOT_LVC3",
    > +                       "IRQ_PVCCIN_CPU1_VRHOT_LVC3",
    > +                       "IRQ_PVDDQ_KLM_VRHOT_LVT3","","P3VBAT_BRIDGE_EN","",
    > +       /*G0-G7*/       "CPU_ERR2_LVT3","CPU_CATERR_LVT3","PCH_BMC_THERMTRIP",
    > +                       "CPU0_SKTOCC_LVT3","","","","BIOS_SMI_ACTIVE",
    > +       /*H0-H7*/       "LED_POST_CODE_0","LED_POST_CODE_1","LED_POST_CODE_2",
    > +                       "LED_POST_CODE_3","LED_POST_CODE_4","LED_POST_CODE_5",
    > +                       "LED_POST_CODE_6","LED_POST_CODE_7",
    > +       /*I0-I7*/       "CPU0_FIVR_FAULT_LVT3","CPU1_FIVR_FAULT_LVT3",
    > +                       "FORCE_ADR","UV_ADR_TRIGGER_EN","","","","",
    > +       /*J0-J7*/       "","","","","","","","",
    > +       /*K0-K7*/       "","","","","","","","",
    > +       /*L0-L7*/       "IRQ_UV_DETECT","IRQ_OC_DETECT","HSC_TIMER_EXP","",
    > +                       "MEM_THERM_EVENT_PCH","PMBUS_ALERT_BUF_EN","","",
    > +       /*M0-M7*/       "CPU0_RC_ERROR","CPU1_RC_ERROR","","OC_DETECT_EN",
    > +                       "CPU0_THERMTRIP_LATCH_LVT3",
    > +                       "CPU1_THERMTRIP_LATCH_LVT3","","",
    > +       /*N0-N7*/       "","","","CPU_MSMI_LVT3","","BIOS_SPI_BMC_CTRL","","",
    > +       /*O0-O7*/       "","","","","","","","",
    > +       /*P0-P7*/       "BOARD_SKU_ID0","BOARD_SKU_ID1","BOARD_SKU_ID2",
    > +                       "BOARD_SKU_ID3","BOARD_SKU_ID4","BMC_PREQ",
    > +                       "BMC_PWR_DEBUG","RST_RSMRST",
    > +       /*Q0-Q7*/       "","","","","UARTSW_LSB","UARTSW_MSB",
    > +                       "POST_CARD_PRES_BMC","PE_BMC_WAKE",
    > +       /*R0-R7*/       "","","BMC_TCK_MUX_SEL","BMC_PRDY",
    > +                       "BMC_XDP_PRSNT_IN","RST_BMC_PLTRST_BUF","SLT_CFG0",
    > +                       "SLT_CFG1",
    > +       /*S0-S7*/       "THROTTLE","BMC_READY","","HSC_SMBUS_SWITCH_EN","",
    > +                       "","","",
    > +       /*T0-T7*/       "","","","","","","","",
    > +       /*U0-U7*/       "","","","","","BMC_FAULT","","",
    > +       /*V0-V7*/       "","","","FAST_PROCHOT_EN","","","","",
    > +       /*W0-W7*/       "","","","","","","","",
    > +       /*X0-X7*/       "","","","GLOBAL_RST_WARN",
    > +                       "CPU0_MEMABC_MEMHOT_LVT3_BMC",
    > +                       "CPU0_MEMDEF_MEMHOT_LVT3_BMC",
    > +                       "CPU1_MEMGHJ_MEMHOT_LVT3_BMC",
    > +                       "CPU1_MEMKLM_MEMHOT_LVT3_BMC",
    > +       /*Y0-Y7*/       "SIO_S3","SIO_S5","BMC_JTAG_SEL","SIO_ONCONTROL","",
    > +                       "","","",
    > +       /*Z0-Z7*/       "","SIO_POWER_GOOD","IRQ_PVDDQ_DEF_VRHOT_LVT3","",
    > +                       "","","","",
    > +       /*AA0-AA7*/     "CPU1_SKTOCC_LVT3","IRQ_SML1_PMBUS_ALERT",
    > +                       "SERVER_POWER_LED","","PECI_MUX_SELECT","UV_HIGH_SET",
    > +                       "","POST_COMPLETE",
    > +       /*AB0-AB7*/     "IRQ_HSC_FAULT","OCP_MEZZA_PRES","","","","","","",
    > +       /*AC0-AC7*/     "","","","","","","","";
    > +};
    > +
    >  &mac0 {
    >         status = "okay";
    >
    > --
    > 2.17.1
    >
    

