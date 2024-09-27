From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 27 Sep 2024 15:09:51 +0930
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for
 Management Board
In-Reply-To: <20240926033534.4174707-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926033534.4174707-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <172741559101.63677.6738786477314974380.b4-ty@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 26 Sep 2024 11:35:33 +0800, Delphine CC Chiu wrote:
> Add I2C mux for Management Board to separate the I2C bus 35 for
> updating CPLD firmware and I2C bus 34 for the other devices.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>

