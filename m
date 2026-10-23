Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF59606A319
	for <linux-aspeed@archiver.kernel.org>; Fri, 23 Oct 2026 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RbFy2B73
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9s6R5yC2z2xwL;
	Fri, 23 Oct 2026 16:30:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792733407;
	cv=none; b=bTlVAQ91vwxt1nWELy9Lfs4fTFHPJ3DHmFkC/QCKwu46R8kzrwdKYehmTpcIfJ02teJEl0hVyD/tGPCbfrlFSur/22Yjp+ZiCjOdsZ3PRQfGNhhWq8fifZe+oEPBDBSVk5+WkENfKlMeXtcQCbGvrDkmUruvvq3BvuiJlsOVVf39zx43Gv31dw6jJmUUTObBp4sp9Vt6XJRgfj9q+WCNAUN+lkjqaIkOsiF8U3l1WGxlA/V+3SJ+DReO7yt4/qY6BaIo90su6+TTz4r1H/GpEGg+UNTTCDCDrmncrIAjcASzAQTYdz5OtI5NY9woNgFzgTeRKiwr2G5cQHuzC4wkJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792733407; c=relaxed/relaxed;
	bh=TQDIQpzHb58nAG54hsnGaeLsZebKKo1ep1+3YouILiY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PJxbkpeJWmluVadCPIRQHmHs9piduqD6A5ol1q237smG3wHNlVHFylNo9J6GWSXBI6BWRAevOoLRG/hSYnOS9jVh9M+e4WfAnH2EaNjiGGgYavrAe1NaWZQs1EYC511EF5AmRTIN+lif8cdmH6A4BPAZZVY0S2M+OoqnrqirveAVTcpIgiELA+unExzsHSEq/+wEOrLyvAf0ud7l1FPDnrq/gc+tz04RbG8z/Wv1NDOQ+H+fPwU9ZNWDymT8Bj/AGbYc8atrjH7UTdT2rnbdRcZfaSWI/zRFAQ1ubkyABTc3/8xCoM94JK5BKg9iUVhmBRkJ1bPa4maafVAU/kAWbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RbFy2B73; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RbFy2B73;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9s6Q6K0Rz2xjh;
	Fri, 23 Oct 2026 16:30:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1792733404;
	bh=TQDIQpzHb58nAG54hsnGaeLsZebKKo1ep1+3YouILiY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RbFy2B73JbdoEwfaZWhw72GGEJ3S18LQVSnu9FB2tp1F62GzNCSAOofV6+ci8j/Qr
	 NTYVIp1W/oSlHcqIpvTGpB3P/t0t0A09IlS1viMM4Mm6czL5gHH9bx4m1QqVQ8wC7F
	 IzPS02S41/QbiwcDyvOPp6AvSa2KUzSIbE9pOo9bG2AsdWi2lakCY1Ys73g5AND+XT
	 yGPPp0XOqjHlK89VohWNdpL155tzNh4xKK69MIdZo6GxV7XGp2AbbxhnYxsrUGuDXO
	 3I1q7aT8mkBYV5hED70/dnKARVm3ekeqWzmRG4UJQJITTHNMQApkJ1lowql7kF/44L
	 i8ZDdGnYoSVnw==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4DFF76C53B;
	Fri, 23 Oct 2026 13:29:56 +0800 (AWST)
Message-ID: <b4bb2f36bde9df1e052a70076fb70118cf3c607c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 2/4] soc: aspeed: Move UART routing driver to
 drivers/uart-routing
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Joel Stanley
	 <joel@jms.id.au>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Oskar Senft
	 <osk@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Jani Nikula
 <jani.nikula@intel.com>,  Vitaly Lubart <lubvital@gmail.com>, Hanjun Guo
 <guohanjun@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Usyskin <alexander.usyskin@intel.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Breno Leitao <leitao@debian.org>,  Philipp Zabel
 <p.zabel@pengutronix.de>, James Morse <james.morse@arm.com>, Paolo Abeni
 <pabeni@redhat.com>,  Stephen Hemminger <stephen@networkplumber.org>, Dave
 Penkler <dpenkler@gmail.com>, Jakub Kicinski <kuba@kernel.org>,  Jonathan
 Cameron	 <jic23@kernel.org>, Dan Williams <djbw@kernel.org>, Mukesh Rathor	
 <mrathor@linux.microsoft.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, Julian Braha
 <julianbraha@gmail.com>, Karthikeyan KS	 <karthiproffesional@gmail.com>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 	openbmc@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org
Date: Fri, 23 Oct 2026 15:59:55 +1030
In-Reply-To: <20261019100643.49099-3-changhuang.liang@starfivetech.com>
References: <20261019100643.49099-1-changhuang.liang@starfivetech.com>
	 <20261019100643.49099-3-changhuang.liang@starfivetech.com>
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-10-19 at 03:06 -0700, Changhuang Liang wrote:
> The Aspeed UART routing driver is not really a SoC driver: it only
> exposes a serial crossbar through sysfs, and the same hardware block
> exists on SoCs from other vendors. Move it to drivers/uart-routing/ and
> convert it to the common framework living there.
>=20
> The register layout description, that is the list of selectors with
> their register offset, bit position, field mask and routing targets, is
> kept as it is; only the surrounding sysfs plumbing is dropped in favour
> of the framework. The per selector option lists become separate arrays
> because the framework refers to them by pointer instead of embedding
> them in the selector.
>=20
> The Kconfig symbol and the platform driver name are unchanged, so the
> sysfs paths documented in
> Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing stay valid
> and existing configurations keep working.
>=20
> Also update MAINTAINERS to add entries for aspeed-uart-routing.c
> based on the file authors, as the file currently lacks maintainers.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
> =C2=A0drivers/soc/aspeed/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 -
> =C2=A0drivers/soc/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/soc/aspeed/aspeed-uart-routing.c=C2=A0=C2=A0 | 601 --------=
-------------
> =C2=A0drivers/uart-routing/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +
> =C2=A0drivers/uart-routing/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/uart-routing/aspeed-uart-routing.c | 415 ++++++++++++++
> =C2=A07 files changed, 443 insertions(+), 612 deletions(-)
> =C2=A0delete mode 100644 drivers/soc/aspeed/aspeed-uart-routing.c
> =C2=A0create mode 100644 drivers/uart-routing/aspeed-uart-routing.c
>=20

I'm certainly in favour of moving code out of drivers/soc/aspeed, and
having a small subsystem to handle this is fine, but it's not clear
what happened to the direction of doing this by designing a user ABI
for pinctrl?

https://lore.kernel.org/all/CAD++jLm7hQnCHACsZH0LVnXuCJm0dZ6Bq0hAyOTvVomy6W=
VRug@mail.gmail.com/

Existing code would need to be converted, but motivating that with the
JHB100 support would seem sensible?

Andrew

