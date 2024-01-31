From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 30 Jan 2024 16:11:55 -0800
Subject: [PATCH 30 3/7] Add Aspeed SOC 24xx, 25xx and 26xx JTAG support
In-Reply-To: <LV8PR11MB846379E82775EFA1C9062D1C8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
References: <LV8PR11MB846379E82775EFA1C9062D1C8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Message-ID: <8fe881af-dab8-456f-8e8a-8d76153c4322@infradead.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 1/30/24 15:30, Corona, Ernesto wrote:
> +config USE_INTERRUPTS
> +	bool "Use interrupts as event wait mechanism"
> +	depends on JTAG_ASPEED
> +	default n
> +	help

This symbol needs some kind of namespacing. It is too generic as is.

Thanks.
-- 
#Randy
