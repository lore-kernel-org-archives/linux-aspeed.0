Return-Path: <linux-aspeed+bounces-2484-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8275CCCD199
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 05:17:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cntPZ5Jbyz2yhX;
	Fri, 17 Oct 2025 16:17:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760678274;
	cv=none; b=Vkk0a9qQNnkp0ycV0gporcd7FUEEPgF7p8TMbEeiS+D5Pu83ekI2rfZm6vOVbZvOzCkYPMxbQTOuC3WXNnnz2FUYjVUzh0iRA2FaKCkjCv1p3PU3FjYH2clgh1Lu//MlM79tuAcuwCZq6mas1cpOD+N9bKsgI0iHMWrMF/7zx/yzpH1U7J3I3TMo4BvyewNYkGC0UzodJxGYpP28EBb8CkwDTfCnH2iaRN0yVJYdk5YyLqc2dfVRXS0vj5+qasmrBv6W8nDVBo47VjVK3fEzHLDhi4dfZq3sj44vqi74+cLTWt/IPLQt88GTimKfdCUtulv0Ll4AyGJ9RzeM63QSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760678274; c=relaxed/relaxed;
	bh=JPM4mlpiishQWeQFEupQtI0yWXJaRSHmeNe+WZxInAk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fcKRGSj2qSCCX6iVJoZu5ez9JZj4vPFrZSaaFgU7Rsiy56R/TS3ad+wiF9XWcR6dU7QntalHt/p1CbnF3ayRaINInQttMDp7+0GyaH4pXyDD5NYOns1fhkzHqvDz6bA+zzvJVZoe9ySxSi+AakmJxe5V6w2hCfCV1Y/zi2J023V8GOWrxusbX2DbOEG6gPk6gFii1uMosZCvMjkA+iAeu0jJZS0ZiEi1A7DXlVInjGlrgJ+SpCYgywGIVeUJfPENJV2voa8IaQgEyIpZ/1xGXKMU7AHVXElq9De3e4NEPRIs9xOQFAdwV99+Frook16dwsXB6MNdR0MmzaHrGSLjAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jPvbvixb; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jPvbvixb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cntPZ2PtCz2xBV
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 16:17:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760678273;
	bh=JPM4mlpiishQWeQFEupQtI0yWXJaRSHmeNe+WZxInAk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jPvbvixbXMKZqhbOdvGCGRfbQ6xz4XZW5OoEp834zvcbcUzeT0DEZQShCifFLvXH/
	 7VNXYSdU2G7KBQWNNJLvpdVm+M3neujB8Z53erIEdu1UJ2Ur/ZNsImsaJHlj4fM+hg
	 pXJ6iktIeSvvkWXkQePecL2LJGSXwTBivc0u1kUyxGFPoHq8uPoFGCjZLd1T70h288
	 XUtXbfrycVVCuJeeKaPuRXQTaJ2o8tU0V5LH3J2I97AhMweppeCmPHR8J6FZsKDRD8
	 AXTsyoypYXqYM3OOtceSmolxJvsYijbhLEvWUBCtsx2wbK42Z7FgkrL++vG1zbFzKz
	 wxyyk4y8wDU0A==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 882AA766F5;
	Fri, 17 Oct 2025 13:17:46 +0800 (AWST)
Message-ID: <57dffe112a461a218c7dab6bfc3b02967440cc77.camel@codeconstruct.com.au>
Subject: Re: [PATCH][v4] hung_task: Panic when there are more than N hung
 tasks at the same time
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: lirongqing <lirongqing@baidu.com>, Andrew Morton
 <akpm@linux-foundation.org>,  Lance Yang <lance.yang@linux.dev>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, 	linux-kselftest@vger.kernel.org, Anshuman Khandual
 <anshuman.khandual@arm.com>,  Arnd Bergmann	 <arnd@arndb.de>, David
 Hildenbrand <david@redhat.com>, Florian Wesphal	 <fw@strlen.de>, Jakub
 Kacinski <kuba@kernel.org>, "Jason A . Donenfeld"	 <jason@zx2c4.com>, Joel
 Granados <joel.granados@kernel.org>, Joel Stanley	 <joel@jms.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,  Liam
 Howlett <liam.howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Paul E . McKenney"	 <paulmck@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Petr Mladek
 <pmladek@suse.com>, Phil Auld <pauld@redhat.com>, Randy Dunlap
 <rdunlap@infradead.org>,  Russell King <linux@armlinux.org.uk>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,  Stanislav Fomichev	
 <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 17 Oct 2025 15:47:45 +1030
In-Reply-To: <20251015063615.2632-1-lirongqing@baidu.com>
References: <20251015063615.2632-1-lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

On Wed, 2025-10-15 at 14:36 +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
>=20
> Currently, when 'hung_task_panic' is enabled, the kernel panics
> immediately upon detecting the first hung task. However, some hung
> tasks are transient and allow system recovery, while persistent hangs
> should trigger a panic when accumulating beyond a threshold.
>=20
> Extend the 'hung_task_panic' sysctl to accept a threshold value
> specifying the number of hung tasks that must be detected before
> triggering a kernel panic. This provides finer control for environments
> where transient hangs may occur but persistent hangs should be fatal.
>=20
> The sysctl now accepts:
> - 0: don't panic (maintains original behavior)
> - 1: panic on first hung task (maintains original behavior)
> - N > 1: panic after N hung tasks are detected in a single scan
>=20
> This maintains backward compatibility while providing flexibility for
> different hang scenarios.
>=20
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Florian Wesphal <fw@strlen.de>
> Cc: Jakub Kacinski <kuba@kernel.org>
> Cc: Jason A. Donenfeld <jason@zx2c4.com>
> Cc: Joel Granados <joel.granados@kernel.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Cc: "Paul E . McKenney" <paulmck@kernel.org>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
> diff with v3: comments modification, suggested by Lance, Masami, Randy an=
d Petr
> diff with v2: do not add a new sysctl, extend hung_task_panic, suggested =
by Kees Cook
>=20
> =C2=A0Documentation/admin-guide/kernel-parameters.txt=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 20 +++++++++++++-------
> =C2=A0Documentation/admin-guide/sysctl/kernel.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++++----
> =C2=A0arch/arm/configs/aspeed_g5_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
2 +-

For the aspeed_g5_defconfig change:

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

