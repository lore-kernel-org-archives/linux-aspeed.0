From: Saravana Kannan <saravanak@google.com>
Date: Tue, 28 Jun 2022 16:17:04 -0000
Subject: [PATCH v1 2/2] serial: Set probe_no_timeout for all DT based drivers
In-Reply-To: <20220628140025.qpom64ptru4ub6fu@distanz.ch>
References: <20220628020110.1601693-1-saravanak@google.com>
 <20220628020110.1601693-3-saravanak@google.com> <20220628140025.qpom64ptru4ub6fu@distanz.ch>
Message-ID: <CAGETcx_7jS3H2cphiXdk=NBfmuPzsusEwPBx75n3PrP6YTnjnA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 28, 2022 at 7:00 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> On 2022-06-28 at 04:01:03 +0200, Saravana Kannan <saravanak@google.com> wrote:
> > diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/8250/8250_acorn.c
> > index 758c4aa203ab..5a6f2f67de4f 100644
> > --- a/drivers/tty/serial/8250/8250_acorn.c
> > +++ b/drivers/tty/serial/8250/8250_acorn.c
> > @@ -114,7 +114,6 @@ static const struct ecard_id serial_cids[] = {
> >  static struct ecard_driver serial_card_driver = {
> >       .probe          = serial_card_probe,
> >       .remove         = serial_card_remove,
> > -     .id_table       = serial_cids,
>
> Is this change intentional? All other drivers are only changed to set
> .probe_no_time and I don't see anything mentioned in the commit message
> re. this driver's change.

No, that's a mistake. Thanks for catching it! I'll check this patch again.

-Saravana
