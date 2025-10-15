Return-Path: <linux-aspeed+bounces-2469-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38219CCD185
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 22:37:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cn5Z650lTz2yr1;
	Thu, 16 Oct 2025 09:37:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=111.202.115.85
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760494131;
	cv=none; b=UZOqbhthxrYFK99o2dhMQNbRC+ftBOyrr6V8RZwv1w3Wzp/V7KNNXUNbRqWdwgVGPU4z7hNyzAZoMmVEO6fu4cnlQQYgqqoCghOYZklckqcfxk9mFRDgCRruEqMewEgSqL9NgInub2llJlCQUDvrJoXTY3XMeMtTAdtqsXuFW+Uvd+zi9lqua9EFrXmkWiGTBQxxz+d/IyXZmtc8Ggae3ZkZ2oTALse90xDZ07rx8MXI4qjgLQh37rRawEWt6akGHwme08rlk0NdL5FHmTx3M97304wDw2JkPz2aGRgUMArPZAk0l499h5W+BuYMzFpDxC0PPN1xXu0eG1zhAP5zkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760494131; c=relaxed/relaxed;
	bh=0r9NwyGV81gEquF2+fhkRQ0hPi0BF08QiWaCnjL52rY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CveJKg2GemZ6TWjlbh3Wv049phQ7JD+qSzV0biv10tOE2kX9LhYmMmuYi7co7jp2DFdCBnxdzMGa8TgIF68gFOazx4+7MUnCjP1Wu43DC2Pyc+cRn3xHITD8XGexuAnR05F+Ku+eXfb3KZBlTRSXey61lqtgN9h+Z/R/5vF2gEIrbBYlN1g5+Nl1z4BjtzreUYOlNOTnb7WM8Zd8XzHHRer+RPYKkDIbKsTExlVkeQCWJFS9XNKlItpCnst/Vg462M09tiBsDLeFytk59FVxkq/Zy3AMNjvp6HkAMvvysUrZ5EwCYrjfLaQ5+ELPLXgJ9uyd2U0tPemyxApm22c75w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass (client-ip=111.202.115.85; helo=baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org) smtp.mailfrom=baidu.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baidu.com (client-ip=111.202.115.85; helo=baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org)
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmZJL3P7Zz3cYV
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 13:08:48 +1100 (AEDT)
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Petr Mladek <pmladek@suse.com>
CC: Lance Yang <lance.yang@linux.dev>, "wireguard@lists.zx2c4.com"
	<wireguard@lists.zx2c4.com>, "linux-arm-kernel@lists.infradead.org"
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
Subject: RE: [????] Re: [????] Re: [PATCH][v3] hung_task: Panic after fixed
 number of hung tasks
Thread-Topic: [????] Re: [????] Re: [PATCH][v3] hung_task: Panic after fixed
 number of hung tasks
Thread-Index: AQHcPO9h0grxiWd7ak27/owdD96L07TBdJLA//+i6ACAAVy0QA==
Date: Wed, 15 Oct 2025 02:04:21 +0000
Message-ID: <b7937a55047b44c687e11e219a62009e@baidu.com>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
 <aO4boXFaIb0_Wiif@pathway.suse.cz>
 <e3f7ddf68c2e42d7abf8643f34d84a18@baidu.com>
 <aO5Ldv4U8QSGgfog@pathway.suse.cz>
In-Reply-To: <aO5Ldv4U8QSGgfog@pathway.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.127.72.27]
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
X-FEAS-Client-IP: 172.31.50.46
X-FE-Policy-ID: 52:10:53:SYSTEM

> I would also update the subject to something like:
>=20
>     hung_task: Panic when there are more than N hung tasks at the same
> time
>=20

Ok, I will update=20

>=20
>=20
> That said, I think that both approaches make sense.
>=20
> Your approach would trigger the panic when many processes are stuck.
> Note that it still might be a transient state. But I agree that the more =
stuck
> processes exist the more serious the problem likely is for the heath of t=
he
> system.
>=20
> My approach would trigger panic when a single process hangs for a long
> time. It will trigger more likely only when the problem is persistent. Th=
e
> seriousness depends on which particular process get stuck.
>=20
Yes, both are reasonable requirement, and I will leave it to you or anyone =
else interested to implement it

Thanks

-Li.


> I am fine with your approach. Just please, make more clear that the numbe=
r
> means the number of hung tasks at the same time.
> And mention the problems to login, ...
>=20
> Best Regards,
> Petr

