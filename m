From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 25 Sep 2024 10:22:17 +0930
Subject: [PATCH v2 0/2] Adjust the setting for SPI flash of yosemite4
In-Reply-To: <20240924094430.272074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240924094430.272074-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <172722553796.384629.2084285836291139720.b4-ty@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 24 Sep 2024 17:44:28 +0800, Delphine CC Chiu wrote:
> - v2
>   - Split the patches for different targets.
> - v1
>   - Revise SPI flash to dual mode.
>   - Revise flash layout to 128MB.
> 
> Ricky CX Wu (2):
>   ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
>   ARM: dts: aspeed: yosemite4: revise flash layout to 128MB
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>

