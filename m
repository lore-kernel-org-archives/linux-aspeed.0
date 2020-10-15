From: Joel Stanley <joel@jms.id.au>
Date: Thu, 15 Oct 2020 02:32:01 +0000
Subject: [PATCH 1/1] net: ftgmac100: Fix Aspeed ast2600 TX hang issue
In-Reply-To: <PS1PR0601MB184990423661220EACDBF4BB9C020@PS1PR0601MB1849.apcprd06.prod.outlook.com>
References: <20201014060632.16085-1-dylan_hung@aspeedtech.com>
 <20201014060632.16085-2-dylan_hung@aspeedtech.com>
 <CACPK8Xe_O44BUaPCEm2j3ZN+d4q6JbjEttLsiCLbWF6GnaqSPg@mail.gmail.com>
 <PS1PR0601MB1849DAC59EDA6A9DB62B4EE09C050@PS1PR0601MB1849.apcprd06.prod.outlook.com>
 <CACPK8Xd_DH+VeaPmXK2b5FXbrOpg_NmT_R4ENzY-=uNo=6HcyQ@mail.gmail.com>
 <PS1PR0601MB184990423661220EACDBF4BB9C020@PS1PR0601MB1849.apcprd06.prod.outlook.com>
Message-ID: <CACPK8XePVhxtV5EXGH8ycHrG03M1JBp4920Hi9EQQfw5mCxJxg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2020 at 01:49, Dylan Hung <dylan_hung@aspeedtech.com> wrote:
> > > I was encountering this issue when I was running the iperf TX test.  The
> > symptom is the TX descriptors are consumed, but no complete packet is sent
> > out.
> >
> > What parameters are you using for iperf? I did a lot of testing with
> > iperf3 (and stress-ng running at the same time) and couldn't reproduce the
> > error.
> >
>
> I simply use "iperf -c <server ip>" on ast2600.  It is very easy to reproduce. I append the log below:
> Noticed that this issue only happens when HW scatter-gather (NETIF_F_SG) is on.

Ok. This appears to be on by default in the
drivers/net/ethernet/faraday/ftgmac100.c:

        netdev->hw_features = NETIF_F_RXCSUM | NETIF_F_HW_CSUM |
                NETIF_F_GRO | NETIF_F_SG | NETIF_F_HW_VLAN_CTAG_RX |
                NETIF_F_HW_VLAN_CTAG_TX;

> [AST /]$ iperf3 -c 192.168.100.89
> Connecting to host 192.168.100.89, port 5201
> [  4] local 192.168.100.45 port 45346 connected to 192.168.100.89 port 5201
> [ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
> [  4]   0.00-1.00   sec  44.8 MBytes   375 Mbits/sec    2   1.43 KBytes
> [  4]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    2   1.43 KBytes
> [  4]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0   1.43 KBytes
> [  4]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    1   1.43 KBytes
> [  4]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   1.43 KBytes
> ^C[  4]   5.00-5.88   sec  0.00 Bytes  0.00 bits/sec    0   1.43 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bandwidth       Retr
> [  4]   0.00-5.88   sec  44.8 MBytes  64.0 Mbits/sec    5             sender
> [  4]   0.00-5.88   sec  0.00 Bytes  0.00 bits/sec                  receiver
> iperf3: interrupt - the client has terminated

I just realised my test machine must be on a 100Mbit network. I will
try testing on a gigabit network.

> > We could only reproduce it when performing other functions, such as
> > debugging/booting the host processor.
> >
> Could it be another issue?

I hope not! We have deployed your patch on our systems and I will let
you know if we see the bug again.

> > > > > +/*
> > > > > + * test mode control register
> > > > > + */
> > > > > +#define FTGMAC100_TM_RQ_TX_VALID_DIS (1 << 28) #define
> > > > > +FTGMAC100_TM_RQ_RR_IDLE_PREV (1 << 27) #define
> > > > > +FTGMAC100_TM_DEFAULT
> > > > \
> > > > > +       (FTGMAC100_TM_RQ_TX_VALID_DIS |
> > > > FTGMAC100_TM_RQ_RR_IDLE_PREV)
> > > >
> > > > Will aspeed issue an updated datasheet with this register documented?
> >
> > Did you see this question?
> >
> Sorry, I missed this question.  Aspeed will update the datasheet accordingly.

Thank you.
