From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 28 Jan 2021 09:46:25 +1030
Subject: =?UTF-8?Q?Re:_[PATCH]_ARM:_dts:_aspeed:_amd-ethanolx:_Enable_secondary_L?=
 =?UTF-8?Q?PC_snooping_address?=
In-Reply-To: <20210127182326.424-1-aladyshev22@gmail.com>
References: <20210127182326.424-1-aladyshev22@gmail.com>
Message-ID: <7d7a0990-c9ca-4113-aa41-415b5cb54cf5@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 28 Jan 2021, at 04:53, Konstantin Aladyshev wrote:
> AMD EthanolX CRB uses 2-byte POST codes which are sent to ports 0x80/0x81.
> Currently ASPEED controller snoops only 0x80 port and therefore captures
> only the lower byte of each POST code.
> Enable secondary LPC snooping address to capture the higher byte of POST
> codes.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
