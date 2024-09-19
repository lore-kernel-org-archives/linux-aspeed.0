From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 19 Sep 2024 11:29:52 +0930
Subject: [PATCH v1 0/2] Yosemite4: Add devices on I2C buses to server
 boards
In-Reply-To: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <172671119203.649222.5621392370744640415.b4-ty@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 13:47:49 +0800, Delphine CC Chiu wrote:
> Changelog:
>   - v1
>     - Revise to use adm1281 on Medusa board.
>     - Add gpio pca9506 for CPLD I/O expander.
> 
> Ricky CX Wu (2):
>   ARM: dts: aspeed: yosemite4: Revise to use adm1281 on Medusa board
>   ARM: dts: aspeed: yosemite4: Add gpio pca9506 for CPLD IOE
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

[1/2] ARM: dts: aspeed: yosemite4: Revise to use adm1281 on Medusa board
      commit: 4c417a6b31471da78b87f9e542f285e2225744e0
[2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506 for CPLD IOE
      commit: 00f897797acf562bcbda20d8ca93f279a0c6bb5b

--
Andrew Jeffery <andrew@codeconstruct.com.au>

