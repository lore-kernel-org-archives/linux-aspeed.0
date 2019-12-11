From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 11 Dec 2019 11:02:08 +1030
Subject: [PATCH v2 02/12] irqchip: Add Aspeed SCU interrupt controller
In-Reply-To: <1575566112-11658-3-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-3-git-send-email-eajames@linux.ibm.com>
Message-ID: <40bf8eb4-2998-43fd-af61-c9063b09ced9@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> The Aspeed SOCs provide some interrupts through the System Control
> Unit registers. Add an interrupt controller that provides these
> interrupts to the system.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
