From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 19 Sep 2024 11:15:42 +0930
Subject: [PATCH v2] ARM: dts: aspeed: Enable PECI and LPC snoop for IBM
 System1
In-Reply-To: <20240918-dts-aspeed-system1-peci-snoop-v2-1-2d4d17403670@gmail.com>
References: <20240918-dts-aspeed-system1-peci-snoop-v2-1-2d4d17403670@gmail.com>
Message-ID: <172671034240.638277.4020741280785958625.b4-ty@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 18 Sep 2024 14:50:03 +0530, Manojkiran Eda wrote:
> This patch enables the PECI interface and configures the LPC Snoop for
> ports 0x80 and 0x81 in the ASPEED BMC for IBM System1.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

[1/1] ARM: dts: aspeed: Enable PECI and LPC snoop for IBM System1
      commit: abfafb7269c3c1d73a2a7136f9d3f7e417c83a4c

--
Andrew Jeffery <andrew@codeconstruct.com.au>

