From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 08 Apr 2021 10:04:03 +0930
Subject: [PATCH 20/22] ARM: dts: aspeed: everest: Enable fan watchdog
In-Reply-To: <20210329150020.13632-21-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
 <20210329150020.13632-21-eajames@linux.ibm.com>
Message-ID: <dbe4fa5f-370a-41fd-a1ab-7b065b5cb8d1@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 30 Mar 2021, at 01:30, Eddie James wrote:
> Set watchdog 1 to pulse the fan watchdog circuit that drives the FAULT
> pin of the MAX31785, resulting in fans running at full speed, if at
> any point the BMC stops pulsing it, such as a BMC reboot at runtime.
> Enable watchdog 2 for BMC reboots.
> 
> Signed-off-by: Matthew Barth <msbarth@linux.ibm.com>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
