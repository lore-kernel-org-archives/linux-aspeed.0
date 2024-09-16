From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 16 Sep 2024 10:51:29 +0200
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting
 for pca9555
In-Reply-To: <TYZPR04MB5853795FDC6497F7E0114E43D69A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240910063952.3006665-1-Delphine_CC_Chiu@wiwynn.com>
 <42049344-fafb-4aee-8423-fe09a1a977f2@kernel.org>
 <TYZPR04MB5853795FDC6497F7E0114E43D69A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
Message-ID: <10de03e4-db98-4b5c-9cf6-3f98a5cc0537@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/09/2024 10:20, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> I will revise in v2. Thanks!
>>> +             interrupt-parent = <&gpio0>;
>>> +             interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
>>> +             gpio-line-names =
>>> +             "P48V_OCP_GPIO1","P48V_OCP_GPIO2",
>>
>> Nothing improved here. I already commented about above and this.
>> Implement feedback for all your patches, not only one.
>>
>> Best regards,
>> Krzysztof
> Sorry about that.
> I saw you say "Broken alignment" in v15 patch.
> Would like to ask if the following format meets your expectations?
> +			gpio-line-names =
> +				"P48V_OCP_GPIO1", "P48V_OCP_GPIO2",
> +				"P48V_OCP_GPIO3", "FAN_BOARD_0_REVISION_0_R",

Please read DTS coding style before posting next version of the patch
(or any patch for DTS). This is still not aligned. There is (almost)
never a blank line after '='.

Best regards,
Krzysztof

