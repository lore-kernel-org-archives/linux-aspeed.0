Return-Path: <linux-aspeed+bounces-1141-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13988C3600B
	for <linux-aspeed@archiver.kernel.org>; Mon, 31 Mar 2025 16:16:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZRGTY3w9Mz2yqT;
	Tue,  1 Apr 2025 03:16:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743437777;
	cv=none; b=oSg8/3Vd3zzu/lqR3QMDgKFad0kLhZsT5KRDUzauX3uYNoizRdx1a/89k05Tos2BbdrW2k7isi8H8a2joqreV6KAH2vPPCfuIH4Dm6UjphqQLGLHmPb1bNd/qitG01FiTnC03mtz//mPbj3Pot7/4/ymqVm5xV1ZKSjzVkh8CajvQ+qnkwhZ8ZF35fKnQlud+wuiDC9nx+6mGtiriUHgQ1sgIbuwDAjv9/A9UJsY1bDydueryTiZhYVgBZV+DCXMs92TLLpUEpGskA2cKeAiNbgtm1WCd3jb55AQ+gFeB54FS2zpKxA/ZAqj+aeTvj9Pu4UIpU5w5uj974vKZ8Eq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743437777; c=relaxed/relaxed;
	bh=ongIBo++HFbn0NqFF6/15Jg95xn4PjVawgwlrGYSnys=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Mg2s9z0gLKhh5efMsKvP8v2OEIxUB3tqNfyex/QYCVeNM8EmsFTxSVwCMpH/GWGO0F5HGAVJBMS1LfmxvK0c073BCccsyJwMlQM+5WHE0Hjdo51R224xp26fvk5YplOtp+c4VRCWB4v/GLj8dRmknwgHCNJgS7/Tn8K/o4C0At1FV5Nu/o8eq+WXL7bL+KREEs2LJ194o3p1KnMPrsyGZAka1ypuCP7wP/pzar7wNyh1AOoE7o27VD0m7VQMdgR+chkfpF+D9jpbyOipDXDARnKT4SEZRyYmh70K1xpWSXNZ0r+WZTqV487803XNtLaMVT/7oS17HFhCAm49ZF1o7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=H6mOFW8O; dkim-atps=neutral; spf=pass (client-ip=212.227.17.11; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=H6mOFW8O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.17.11; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 1428 seconds by postgrey-1.37 at boromir; Tue, 01 Apr 2025 03:16:14 AEDT
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZRGTV6qgmz2yVX
	for <linux-aspeed@lists.ozlabs.org>; Tue,  1 Apr 2025 03:16:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743437749; x=1744042549; i=markus.elfring@web.de;
	bh=ongIBo++HFbn0NqFF6/15Jg95xn4PjVawgwlrGYSnys=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H6mOFW8OD8FstaGCGFkhdJ03x8v7LkcTu/U4KUm4pCi3rt4guHvMf3V/BNf6h1uk
	 KPQCPxc3lH7S8VjLLn7tsmUs5rW7hoaqJOnShwOpwlaOiP6X1EIdLl6JWTO4dmdN1
	 h2NeeUxTpcvshsf170R4kT5E0Mu2MRhsKz9IgrCY663Tm9kFPHiWmmGUlWpTQUCpZ
	 AeaeWVBfyzu7w4emavadcQEAari8nIaIpweqHdhFlm2FIHwdzwCbZ1GptSN0oQo2K
	 IW0HZ6xO/wYQ7X14JrvKzAPCmlC0eaKu/UmlKZHHwydA86F4BtbPQOC3GiW/bIVYn
	 5OuYTr1/i8rEOnaBUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.37]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL4Y-1tvvjk3V7U-00EZdU; Mon, 31
 Mar 2025 18:15:48 +0200
Message-ID: <8cd011a2-67af-47bd-a05a-905eb333180b@web.de>
Date: Mon, 31 Mar 2025 18:15:46 +0200
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Arnd Bergmann <arnd@arndb.de>,
 Gabriel Somlo <gsomlo@gmail.com>, Herve Codina <herve.codina@bootlin.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20250331154002.14128-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v3] drivers/misc: Add NULL check in
 aspeed_lpc_enable_snoop
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250331154002.14128-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lYijUOEiHoRB9NGC01Dedke5GNycctJPJmpQkQahVipGe7YJ0+q
 hbLKpicLEn97cVSUWr0mcHqONoddhsJevKtRBS6wwWTEQIZMoXZRTIwnpZznhy5YxKFSrEv
 aG9bVbuwCq/xPV0uR6lt4OYA97ipJpTT1gVPcS4dIG+YE7qiWNAJvPXqVqhFIsN9s6flPOq
 5xA9OFtw/KJ/8Ka+HXLcQ==
UI-OutboundReport: notjunk:1;M01:P0:5oG7VCXH8og=;P15nKdTwkUBxynx5MUowVvpmB3b
 FRjy02zxityj2sJk+NqUkCD4kdFgK3chCFghCvQprY841gpT4B1iPmDbt3CBKDFSj4sr6d5+Z
 L7FyuCAtsq1nNIOMo0GGlPZG7fGXQNytTbd5sPL+p7CXjizlWE0ZlYgnFe/vzPiGcqzZUXpSa
 YsmwuMOQ1pVncNaiRa0TtJhm8lmsLY1DVRBRvmohb7BBUv2EX7PlFcBPgP79+BYGPm0YzuZH9
 OrP+xxPZxKfSIspxJ3qxZZp6D8tzTJqs3KiYAqXrUbmiLOnOTzkxYJ3Mr+BBhfa3XjeVaXO5e
 vO4O2uUAF4eNfojJjLbF6MxzirBw+02KGeoLTYLW7C3S1bbHuRTylCgAFy3Yd1M9z2cExFhdH
 9/4kU7N2WZDehcjvwdTexXxJr9Fq4jcFwII1/DWCfiZwgc0K9LV4xKE5NaDg0CWxy/skROK1D
 EhhLGyrlCeKgVQiKYuyw4KnoA6kdlCba3pQOoLS9ly+E8LpdOReQUyVMDixuEVIRd7XP5Eouf
 xNXqqIxKw7HTaJwygubijjNtlNiRPaVCoZfoc1yRbYEsZUthHMw+g4dJrBhBHC2SApZp1RqGE
 QimUsR4AvtCblSmqevdKPCXK972Y1vJ3wZ0Q841z/jwsVuguu0cixPncQs5oihwwTdJEuXQhQ
 NMYLwItlrJ18oen9Qbonl2GZlmjxM9New8qoJp1LyHtm1urZkgdd9AMhPeZCsWJI/uAL7Uv/F
 XGQc5PT4GoWC/uZ20U21bmKtAsQB8BxlgJxjC2UAluLBzUqQpfohb3z+ar4YHWANqIJ8xp5gd
 gScUWf6CIIToIa2c99R8VsimZz1n7o3k9UqoNNcmQbx8n580qf4/rZFJ+bpF6PRcOIiwJO37j
 Almw5Grpb5yItYtBnN3PxAjGGVrMqYec6jLWiIqFVR8ZV97E3niesur+uCcYO3qkGbv137lAB
 0HosRDEQZMtboFp8lLsGfCkMQZ/HCy0WQeDyOpYo/RHwRK3jfiXCbN89NPBqzXLkESRNp1tWY
 Iv3Y0h7bb/+iTZy2JXXc87NWmFuWx/5e9k9kaFVmCazZZBpimTca3GUGG5Tn8zgEv+0HB+OIR
 Q5SMRcoveP/bX8nJmLI1nXqUOBBLI8hizrEtaNf+ffHdd2BvCqePHmYY/wpXaU2nQLdkLiZ3w
 6U/TFqgleP9oBJlM7bq4qsXatAnI+Egk00g4X9fdh6kBCRQ4RbWXLKxqQ4duosaDLT/JDID3D
 mYHBtoXnLlVuwA+Zio8vdN5GtK9FC5iN+qAc5mMyZnzfV/WM0+tjlElLMhARCaoijDVORjxyO
 A3HM+ZLgbHYfkdIlcRNnwxszJeFLlkIbreBB0HSwQRaAT2qaYTKkm2qv1q/WmjS/Klo5JzAjJ
 RRhIrUt4aONDCFI50yCm8QhCwnaVEPf9JvCKSIn6FFTP7DjSxzVomsM9QeWjZhTE4fpEm9G36
 AqVxRT5xIT3bnintaqAKFdbmweB742Qe0fdv9h/35V+VO9kkDpEF8Nbx2ENv/O2Ckjjy8mw==

> devm_kasprintf() returns NULL if memory allocation fails. Currently,
=E2=80=A6
                 call?                               failed?


> The corrected code adds error checking and optimizes resource release lo=
gic
=E2=80=A6

See also once more:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14#n94


An other subsystem specification might be more desirable.
https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/lo=
g/drivers/soc/aspeed/aspeed-lpc-snoop.c?h=3Dnext-20250331


* May the array access be simplified another bit here?
* How do you think about to store a pointer to a corresponding data struct=
ure member
  in an additional local variable?


Regards,
Markus

