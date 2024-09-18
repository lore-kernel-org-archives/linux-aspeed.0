From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 18 Sep 2024 09:57:55 +0930
Subject: [PATCH] ARM: dts: aspeed: Fix Rainier and Blueridge GPIO LED
 names
In-Reply-To: <20240917162100.1386130-1-eajames@linux.ibm.com>
References: <20240917162100.1386130-1-eajames@linux.ibm.com>
Message-ID: <172661927571.3432555.2039083339536065640.b4-ty@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 17 Sep 2024 11:21:00 -0500, Eddie James wrote:
> Blueridge LED names to include the "led-" prefix as is proper.
> Rainier should match for ease of application design. In addition,
> the gpio line name ought to match.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

[1/1] ARM: dts: aspeed: Fix Rainier and Blueridge GPIO LED names
      commit: bb5d0b3ea047506a8a55dec5f39977bd05a4ac98

--
Andrew Jeffery <andrew@codeconstruct.com.au>

