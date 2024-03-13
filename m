From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Wed, 13 Mar 2024 06:57:25 +0000
Subject: [PATCH v1] pinctrl: pinctrl-aspeed-g6: correct the offset of
 SCU630
In-Reply-To: <20240313024210.31452-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240313024210.31452-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <TYZPR04MB58539A1D94340F330CAF3CF9D62A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> Sent: Wednesday, March 13, 2024 10:42 AM
> To: patrick at stwcx.xyz; Andrew Jeffery <andrew@codeconstruct.com.au>; Linus
> Walleij <linus.walleij@linaro.org>; Joel Stanley <joel@jms.id.au>
> Cc: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> linux-aspeed at lists.ozlabs.org; openbmc at lists.ozlabs.org;
> linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: [PATCH v1] pinctrl: pinctrl-aspeed-g6: correct the offset of SCU630
> 
> Description:
> Correct the offset of "Disable GPIO Internal Pull-Down #4" register that should
> be 630h according to the AST2620 datasheet.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---

Hi,
Please don't review this patch since ASPEED also provided the patch to
fix this issue.
Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: winmail.dat
Type: application/ms-tnef
Size: 13956 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240313/3e456647/attachment-0001.bin>
