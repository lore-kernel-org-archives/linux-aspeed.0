Return-Path: <linux-aspeed+bounces-2446-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33569CCD184
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 21:59:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmSmp2s1Jz2xdg;
	Wed, 15 Oct 2025 08:59:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.181.3.85
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760439283;
	cv=none; b=Pj4Mth3hhQ4KmW/2DpWV5GGwZ2yiYCOQkgXAN4MQLdMk9Wr927Wv2yeF4wnyCoevTd3w+4uXQ8be34GKCdrJTJC5NPhI06z9xXC7P0xAfQ7VIu+vvdcvw9+Kvd/x9R552wYh29Ob74Ong78zQDqCuFVdQu2FNKTJTTylpOUOGCB96my4nntJmHtQWcrDPaAKsf2isd+PNfG3zLY63W0MvFYYSShM3YIaCfZ46PAzSz2tnlb9FNNeEKrlpKt5bLbKtplBAvBYLcSA9nml9+t73lTKVvP4t9etJBDOUUDcoesm2E4jh2bXckDzxAdSXAACrTcOeZBf4UnaRPCQ1HW+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760439283; c=relaxed/relaxed;
	bh=mQd3ZCB2OykJhGcI77myIoQ+2DEQuY62Xj9+uOMKiBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oGeg8tH5pPY8eP++OhYoVE8Z2CwxC1g+9c2A3i8t/jMzNy5NzfiIyX6vSfg91MZflj3UdV9DwNPvnLnjAP84sT90WyQ2UHnz5UdBcD0P5UtISKtCd8sptt2fUTY3lZfySGVfGwC7mP882nNNNtVtM5M/JwfxMPPeud0kE6xnjbe9Q2tLUNRDNHr507lwk0uC72xLUuCZDU6Bw/qfmk/sQUO/4Gu2g+bxho1U99q5LfdTdzcAm+cBgZvJPnbDGE3UXM3R22S6YRLiZfjpU5N8womoGr5AwJk8zwAAT/P4sk8u3tT1dL0KmzRVKcbD1w9XDRFM6Zx0zP2zCt5HRKC4Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass (client-ip=220.181.3.85; helo=baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org) smtp.mailfrom=baidu.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baidu.com (client-ip=220.181.3.85; helo=baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org)
Received: from baidu.com (mx21.baidu.com [220.181.3.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmB1Z1lHMz3cQx
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 21:54:40 +1100 (AEDT)
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Petr Mladek <pmladek@suse.com>, Lance Yang <lance.yang@linux.dev>
CC: "wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, David Hildenbrand <david@redhat.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, Stanislav Fomichev <sdf@fomichev.me>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
	"Russell King" <linux@armlinux.org.uk>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, "Jonathan Corbet" <corbet@lwn.net>, Joel Granados
	<joel.granados@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, Phil
 Auld <pauld@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, "Pawan Gupta"
	<pawan.kumar.gupta@linux.intel.com>, Simon Horman <horms@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>, Florian Westphal
	<fw@strlen.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Kees Cook
	<kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Paul E . McKenney"
	<paulmck@kernel.org>, Feng Tang <feng.tang@linux.alibaba.com>, "Jason A .
 Donenfeld" <Jason@zx2c4.com>
Subject: RE: [????] Re: [PATCH][v3] hung_task: Panic after fixed number of
 hung tasks
Thread-Topic: [????] Re: [PATCH][v3] hung_task: Panic after fixed number of
 hung tasks
Thread-Index: AQHcPO9h0grxiWd7ak27/owdD96L07TBdJLA
Date: Tue, 14 Oct 2025 10:49:53 +0000
Message-ID: <e3f7ddf68c2e42d7abf8643f34d84a18@baidu.com>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
 <aO4boXFaIb0_Wiif@pathway.suse.cz>
In-Reply-To: <aO4boXFaIb0_Wiif@pathway.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.127.72.24]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.48
X-FE-Policy-ID: 52:10:53:SYSTEM


> On Tue 2025-10-14 13:23:58, Lance Yang wrote:
> > Thanks for the patch!
> >
> > I noticed the implementation panics only when N tasks are detected
> > within a single scan, because total_hung_task is reset for each
> > check_hung_uninterruptible_tasks() run.
>=20
> Great catch!
>=20
> Does it make sense?
> Is is the intended behavior, please?
>=20

Yes, this is intended behavior

> > So some suggestions to align the documentation with the code's
> > behavior below :)
>=20
> > On 2025/10/12 19:50, lirongqing wrote:
> > > From: Li RongQing <lirongqing@baidu.com>
> > >
> > > Currently, when 'hung_task_panic' is enabled, the kernel panics
> > > immediately upon detecting the first hung task. However, some hung
> > > tasks are transient and the system can recover, while others are
> > > persistent and may accumulate progressively.
>=20
> My understanding is that this patch wanted to do:
>=20
>    + report even temporary stalls
>    + panic only when the stall was much longer and likely persistent
>=20
> Which might make some sense. But the code does something else.
>=20

A single task hanging for an extended period may not be a critical issue, a=
s users might still log into the system to investigate. However, if multipl=
e tasks hang simultaneously-such as in cases of I/O hangs caused by disk fa=
ilures-it could prevent users from logging in and become a serious problem,=
 and a panic is expected.=20


> > > --- a/kernel/hung_task.c
> > > +++ b/kernel/hung_task.c
> > > @@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct
> *t, unsigned long timeout)
> > >   	 */
> > >   	sysctl_hung_task_detect_count++;
> > > +	total_hung_task =3D sysctl_hung_task_detect_count -
> > > +prev_detect_count;
> > >   	trace_sched_process_hang(t);
> > > -	if (sysctl_hung_task_panic) {
> > > +	if (sysctl_hung_task_panic &&
> > > +			(total_hung_task >=3D sysctl_hung_task_panic)) {
> > >   		console_verbose();
> > >   		hung_task_show_lock =3D true;
> > >   		hung_task_call_panic =3D true;
>=20
> I would expect that this patch added another counter, similar to
> sysctl_hung_task_detect_count. It would be incremented only once per chec=
k
> when a hung task was detected. And it would be cleared (reset) when no
> hung task was found.
>=20
> Best Regards,
> Petr

