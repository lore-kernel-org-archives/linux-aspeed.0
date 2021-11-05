From: Oskar Senft <osk@google.com>
Date: Thu, 4 Nov 2021 21:01:35 -0400
Subject: [PATCH] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
In-Reply-To: <CACPK8XfXuU4i4khbpo8rxqxT9zz021N_m=s8uinoT+nHbCa_Yg@mail.gmail.com>
References: <20211104210914.4160448-1-osk@google.com>
 <CACPK8XfXuU4i4khbpo8rxqxT9zz021N_m=s8uinoT+nHbCa_Yg@mail.gmail.com>
Message-ID: <CABoTLcQkds=-RjoY+fTVKyR1r+7Axb2-kFC7DiqMcEQTtJgk6g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel

> > +               channel at 0 { /* LTD */
> > +                       reg = <0>;
> > +                       status = "okay";
>
> The status = "okay" should be redundant; as long as  you don't specify
> a status, a node is assumed to be enabled.

My apologies! I know you mentioned something similar for the DTS
binding patch. I didn't realize that this was a generic statement,
rather than limited to the example in the binding. Fixed in PATCH v2.

Oskar.
