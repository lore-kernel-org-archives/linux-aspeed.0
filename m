Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2869606A319
	for <linux-aspeed@archiver.kernel.org>; Fri, 23 Oct 2026 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ap4s7NlN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9qcn5m6yz2xwL;
	Fri, 23 Oct 2026 15:22:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792729369;
	cv=none; b=Khqt1bqZTib/MW4xVvBrTzz4NT1/rvwheAcX8ttcYS88XmZZVNSCRNFYDCvFJBiVVi4PJMbugVI4+RvfjuTe+L5L1y/9ayCie9N6xnVuaOfb+/isXXAOCvPUAQ2WCaoxULOiuObwvSFhPoWfofRjbfvZPghkbw52rXTtYtrn/RViugrYWNQcsQN7nkQY4fofcNISLblMJaErtl96l/F/tf2+LXheJWkBTJuUIpvpxSQpMi1wA6VXR9edCNmXnEBS3+wAmUFd5g4bgEgU7gVsshpW5yCjaMRtFHU8Q8uAMyzokjx13Unkko0UNSXQWPO/2+BkN/tclnFm5EUxajmRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792729369; c=relaxed/relaxed;
	bh=tZVpAtWdlXnl6TCMo3CWgTWfWWIdH1q4ozjaVaEEH/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WeiZPmjz8slSTJHf8TOwyNBWFQc6sZvdF9AU4MT+XdEAqSa1/Qz2tNp5OGAAhgQpoS3zj8i5+VeFUGXbkncTZTry8kv5D8ewJriuTby+2xt1AhhPbL0ob3NUkL2Qc0wBgojo9GCBafA+5MyFtP7en7+ItXxi/GvbDPWUnhyQmClBnEr1VetjYEwDHUQno/ic4Xqirsh744REh1hdQvkAFs807bnTUtSEDQHu5qFxE9SbKoW0BxiEUFtlLg40pMrWXggDJuBx35Zn0aiLz7FbkBbXwJs92/TUxblSL/+3yOpIXzOE5NmuEXdVnj1WhHAiSXDvhXhd8ieWdWncdmtIOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ap4s7NlN; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ap4s7NlN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 332 seconds by postgrey-1.37 at boromir; Fri, 23 Oct 2026 15:22:48 AEDT
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9qcm0wwPz2xSl
	for <linux-aspeed@lists.ozlabs.org>; Fri, 23 Oct 2026 15:22:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1792729034;
	bh=tZVpAtWdlXnl6TCMo3CWgTWfWWIdH1q4ozjaVaEEH/s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ap4s7NlNiTcogMEaK1gbk3o45IVbbObCjTB8Zd3YlYLo2GqMiCYw+xvFAzDO7AzDg
	 w76/DIpHgm91TDrWzcca66EF5BL5uefA0aw4PNS9SoXB9QPgMVkkJVnQN4Fw1dLZUc
	 8LVB75coOiCtrgpZzg0+EUbRQNDNySyVGxtTekLSq8O8uVzzaeHWght4WyBWqdrxDH
	 uRlfXMcraH3oAxdD64NhnulQK+hp9bXDRmTl73+mJa8D6b8/CSFGztPWNFHINfd7Rr
	 aQ3qTWedOpXMdzhyZOeBOH/pvXZgnOVlUq0ecYvx3tkJpR7J9fJoZe/S+Prc/je9LK
	 qb87PlEq67/Cw==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E1AA46A64B;
	Fri, 23 Oct 2026 12:17:12 +0800 (AWST)
Message-ID: <fb048449033e125df93c2925d6dccafbd4114685.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 0/3] arm: dts: aspeed: add Intel AVCRP and JNCRP BMC
 platforms
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Dawid Glazik <dawid.glazik@linux.intel.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	maciej.lawniczak@intel.com
Date: Fri, 23 Oct 2026 14:47:11 +1030
In-Reply-To: <cover.1792613583.git.dawid.glazik@linux.intel.com>
References: <cover.1792613583.git.dawid.glazik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dawid,

On Wed, 2026-10-21 at 22:26 +0200, Dawid Glazik wrote:
> This series adds initial upstream support for the Intel AVCRP and JNCRP
> BMC platforms based on the ASPEED AST2600.
>=20
> The first patch adds the board compatibles to the ASPEED binding. The
> remaining two patches add the board DTS files and register them in the
> ASPEED DTB build list.
>=20
> Dawid Glazik (3):
> =C2=A0 dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
> =C2=A0 ARM: dts: aspeed: add Intel AVCRP BMC
> =C2=A0 ARM: dts: aspeed: add Intel JNCRP BMC
>=20
> =C2=A0.../bindings/arm/aspeed/aspeed.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0.../dts/aspeed/aspeed-bmc-intel-avcrp.dts=C2=A0=C2=A0=C2=A0=C2=A0 |=
 322 ++++++++++++++++++
> =C2=A0.../dts/aspeed/aspeed-bmc-intel-jncrp.dts=C2=A0=C2=A0=C2=A0=C2=A0 |=
 276 +++++++++++++++
> =C2=A04 files changed, 602 insertions(+)
> =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.=
dts
> =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.=
dts
>=20
>=20
> base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d

Can you please discuss why you based this series on v7.1-rc5? v7.3 has
been released, v7.1-rc5 is a long time ago.

In the future please base changes for the AST2600 on the latest -rc1,
or the aspeed/arm/dt branch of bmc/linux.git on git.kernel.org.

Rebasing allows you to remove 2/3rds of this prerequisite list.

> prerequisite-patch-id: 3af4bd880f896c97741b54ee18845b305a4bd061

This was already applied in 7.2

> prerequisite-patch-id: 23091b539ec7723a865d82da7703bf70c6ed0222

Can you please rebase this patch to send it to Lee on its own. The
AST2600-based platforms currently generate a warning without it. I had
hoped Lee would apply it in the same cycle.

> prerequisite-patch-id: ac42a7a373fdc407f6377d0b1c74d728af50ba42

This was already applied in 7.2

Andrew

