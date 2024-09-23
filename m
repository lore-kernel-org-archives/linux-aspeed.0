From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 23 Sep 2024 10:32:32 +0930
Subject: [PATCH v19 2/2] ARM: dts: aspeed: yosemite4: add mctp config
 and sensors for NIC
In-Reply-To: <20240920070449.3871705-3-Delphine_CC_Chiu@wiwynn.com>
References: <20240920070449.3871705-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240920070449.3871705-3-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <a93f32cba7721cc6874d0baf0b29e1cc9bfe15c1.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-20 at 15:04 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> - Add MCTP config for NIC and remove the unnecessary MCTP config on bus
> 15.
> - Add eeprom for NIC.

There's no suggestion that these are related. Why are they done in the
same commit?

Andrew
