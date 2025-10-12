Return-Path: <linux-aspeed+bounces-2424-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BF0CCD187
	for <linux-aspeed@archiver.kernel.org>; Sun, 12 Oct 2025 13:42:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cl1rM1TRNz3cbg;
	Mon, 13 Oct 2025 00:42:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760276563;
	cv=none; b=idK4sUkGA7CmaCC1boPVC9uPUxfbrLdsHUn1vWdgM+qUijTmeU73cUcSqWJWPiSLjjJsk67SgI1/gLl2VS2ELHEP+apwdJg5baJyXHmD/HhWJ2tVkHep1vphbnUlS5azvc+3viMJFFyJ0UNlt5XUikh5SY2vnZsO8uz5/jlyVVLU6f27+gq4WkQCMv3AuJznN6b1q8zqrrEvDvCbfkHNgcV40SICqdnLRBpU73LhZbSJdFYMO/p9QHzIpjDIYtS84sJgdFQwRlqHCmbtaTLsTEG8t6Wb1VpE7pErse3n03H2h8OWAV2L28bGjd9NdSCNvGDOieoOPZQo6G0bBVo+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760276563; c=relaxed/relaxed;
	bh=yVG8ADOPDzqUmkywmgv9dc2B90UlYkCVvSg1ciAYIFg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kLfD5P/wGV5iOlmvv35fvi8EJXzUNRoOZ7HYjrkIUNgCa7YuSo34izaP34B2KRmkt5qhy6rpgC3nRTtKoP5sJwY3O/R33JJQ7gJWG+CEAItYZGethtOPIJ1uZfy5fBCvQPCW+MF4MEoN1m5GNTqfTtdlBYwOyFQXeYJGV7RYA/5wvAytQ7JHYCgHwiSLnVAhxyFunjBPZqxl38yeyWi2JZIcjowggzSw+eCtsj+2UqQP/ibFHomoJh4ru5N1HABjFZjH7QhYOTNaL391iu4jKEq093nzsqovgKphS1zS1EjLvsA6yuEfmMUexWgkRzJSWFGaLblTzpvYx/wRv4HUFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=rPhOa6+v; dkim-atps=neutral; spf=pass (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=rPhOa6+v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 918 seconds by postgrey-1.37 at boromir; Mon, 13 Oct 2025 00:42:39 AEDT
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cl1rH6RvRz3cZy
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Oct 2025 00:42:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760276553; x=1760881353; i=markus.elfring@web.de;
	bh=yVG8ADOPDzqUmkywmgv9dc2B90UlYkCVvSg1ciAYIFg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rPhOa6+vtjbw/V117F31QRFS1PEATb+wjN65Up+SyG2SJ39JUwmAGsYwiO1JgF/y
	 5Zi5vTNtFm7CMauNERwjmsCRWeyYbCe+lFERXOrqykv+sTQksNtUN+KAc/j3ClSBi
	 XhKV7dVGiXV5HGM7PoR/1/FWgB7WycJCww3ADj2v7TqWB+2Sr/FRIaC9oH7UiFdzh
	 sYgxteHhnhwBodhoaGVFP66813UZWG3srmzPDrYYs4CwVSRdoz0uE8LBiifDlVOmp
	 4k9Y4zVejdrLvFKrcMWmHTxkTK9EKC2MdOmHzaOdVhMo5Hn77DVVT+8ET9GmCXI79
	 AbpSbZEV+qHdH/5Riw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfU1-1urnDm441j-00VjQA; Sun, 12
 Oct 2025 15:26:34 +0200
Message-ID: <0aea408f-f6d7-4e2d-8cee-1801ad7f3139@web.de>
Date: Sun, 12 Oct 2025 15:26:20 +0200
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
User-Agent: Mozilla Thunderbird
To: Li RongQing <lirongqing@baidu.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 wireguard@lists.zx2c4.com, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, David Hildenbrand <david@redhat.com>,
 Feng Tang <feng.tang@linux.alibaba.com>, Florian Westphal <fw@strlen.de>,
 Jakub Kicinski <kuba@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Joel Granados <joel.granados@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Petr Mladek <pmladek@suse.com>, Phil Auld <pauld@redhat.com>,
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20251012115035.2169-1-lirongqing@baidu.com>
Subject: Re: [PATCH v3] hung_task: Panic after fixed number of hung tasks
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251012115035.2169-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WAgp8h3DyF6g11AayvlQAbFiTVzjoFCtdKXHQo068coehoUT01P
 bW6tgArZAVON6B1QS/KDDP2llblnKalEayJyP8SUrAkR49Edq95sn6phJexJn8o27fA/S0y
 1cIqFOnqVLrsmWwTO+jLfK/uCP4ll9phmEtknMatXpyd6vM5267T2cBLBfCQ7rQmSBpkzAc
 Y/rAKFr/N7Lq0QmKzb1Xw==
UI-OutboundReport: notjunk:1;M01:P0:MeJs4132CB0=;bLvnYNwj2DBoDG/MAUqxmP/dO1Y
 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
 4W8aA==

=E2=80=A6
> This patch extends the =E2=80=A6

Will another imperative wording approach become more helpful for an improv=
ed
change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n94


=E2=80=A6
> +++ b/kernel/hung_task.c
=E2=80=A6
@@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct *t, un=
signed long timeout)
=E2=80=A6
>  	trace_sched_process_hang(t);
> =20
> -	if (sysctl_hung_task_panic) {
> +	if (sysctl_hung_task_panic &&
> +			(total_hung_task >=3D sysctl_hung_task_panic)) {
=E2=80=A6

I suggest to use the following source code variant instead.

	if (sysctl_hung_task_panic && total_hung_task >=3D sysctl_hung_task_panic=
) {


Regards,
Markus

