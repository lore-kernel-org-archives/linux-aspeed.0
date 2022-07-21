From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 21 Jul 2022 12:02:07 +0930
Subject: [PATCH 2/4] ARM: dts: aspeed: ethanolx: Configure RTS/CTS for UART1
In-Reply-To: <20220611095828.1090-3-aladyshev22@gmail.com>
References: <20220611095828.1090-1-aladyshev22@gmail.com>
 <20220611095828.1090-3-aladyshev22@gmail.com>
Message-ID: <04383a64-be4e-46f9-b996-3db28244b3a8@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 11 Jun 2022, at 19:28, Konstantin Aladyshev wrote:
> UART1 is used for connection to the main EPYC CPU. Besides the main
> TX/RX signals this connection has flow control signals RTS/CTS,
> therefore configure this pins on the BMC side.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
