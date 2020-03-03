From: Joel Stanley <joel@jms.id.au>
Date: Tue, 3 Mar 2020 07:15:31 +0000
Subject: [PATCH 00/23] mtd: spi-nor: Move manufacturer/SFDP code out of
 the core
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Message-ID: <CACPK8Xcvf2wSE5Y4E8Lbs6R9mHhztvNsr8vNrYaPX+kMMUhZvA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Tudor,

On Mon, 2 Mar 2020 at 18:07, <Tudor.Ambarus@microchip.com> wrote:
>
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>
> Hello,
>
> This patch series is an attempt at getting all manufacturer specific
> quirks/code out of the core to make the core logic more readable and
> thus ease maintainance.

I tried to apply this to linus' tree (5.6-rc4) but it had a bunch of
conflicts. What did you base this on?
