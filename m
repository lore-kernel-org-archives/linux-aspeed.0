From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 05 Sep 2019 09:16:53 +0800
Subject: [PATCH v2 2/3] dt-bindings: serial: 8250: Add documentation for
 espi-enabled.
In-Reply-To: <b4670171-e161-4d7a-91dc-a1e5a95f7dbc@www.fastmail.com>
References: <20190731013404.243755-1-osk@google.com>
 <20190731013404.243755-2-osk@google.com>
 <b4670171-e161-4d7a-91dc-a1e5a95f7dbc@www.fastmail.com>
Message-ID: <f1d2757119807a48833eba193cd9b443dde0ccba.camel@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Oskar,

> Given it's ASPEED-specific I expect you should use a vendor prefix for the
> property, e.g. aspeed,espi-enabled.
> 
> However, as I understand it you want to determine what polarity the SIRQ
> should be regardless of which of eSPI or LPC are enabled, so I don't think
> the property name should be an explicit statement about eSPI. Maybe
> "aspeed,sirq-polarity-sense"?

Yep, +1 on Andrew's comments here. This property isn't an indication on
whether espi is enabled, but a method to detect it.

Cheers,


Jeremy

