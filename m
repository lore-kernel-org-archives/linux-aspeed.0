Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C92606A330
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=L8BOQL94
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPQjJ5rfwz2yDD;
	Wed, 11 Nov 2026 12:21:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794360116;
	cv=none; b=U2gdU0KsFsAkiz8xpU9GdF7epf9wDIbLQUaTDAAql8aEsn1dj6cjHTdpT0ZEHkgHmLHospn5Un5pXtLU68c7/Cb6XGHYM7hdetPPDKW2oWDKXeMGUvK33ai/EjUXeJHv6vaZDLIngBOhMyXWpMVBFtrmEVYE+XeNMCeii8wfbIVDxTPO0wJ7dHEvduSdKC93EJ6vM6/dhc20aGNuvnjk4sWi2zSpEa5NUD5g5GZsSkAHhBR0185O838zMXMz8B4UpJqyGobdSyj4rJuHjNME61UwrwhcbBfKX1cCEqCTQ1lbfesxzypjzwkrmFYKJBswkdYE94MFcAUcRgpQT8IEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794360116; c=relaxed/relaxed;
	bh=8ZZk9oEGAIjQ2tF3K4JfYaKrxUDTTjE79kClK2OjhcE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X6XBLZNPiO/jxXewDID7CDqwthpT9thlSyxg4te+GxlYfd/ajJQAaVbVeEVngPspLaZRADcqzhxnUb0nCTUlHha5ZdQU0kT6tziqF0bPaL64x6XyuaGQCfmgVy/9hc4SxpUdMhIywyqDmw4WJERdGDUTRiIV+SJcWpaXEM1GxQaOmNkYjSfVm7x1/Clb7cIdIb5jq0U0kX8byOekBc2ep3732nDewhj28GIVdeUZgPkUS3Kd0UkRrjsY4Y5xFLc/ZCCATqY7NU1qcMC9kAsojJK0Q2071AoWx7f1MDGWYYGHWVl/iXtdajoT0erKO3C0hCI1A+wwb9Gcx/BFxenIEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=L8BOQL94; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=L8BOQL94;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPQjJ0wHlz2xM9
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 12:21:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794360114;
	bh=8ZZk9oEGAIjQ2tF3K4JfYaKrxUDTTjE79kClK2OjhcE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L8BOQL94I2g3NOqQh4X2CDZ9nBgiSyCun7TWRPgsPkU85idmewltrojo+I1blRbE3
	 zJoeAAMAjylQ0kXJlot9qZrBhlj/sQsUhnW44OZmzt1Tq4zMBlrZemXE3+ZEAGPrTM
	 Ff1NmHE4KW5QHaiCMwlJ9UTjoKPuTmlsF36bXWuZujMHUrUq45S72M/NhsCybCj+3h
	 lDSbmjxABpAhKWJ2/AdaWpzAEYJDG8KTuIMlRbk524qXP2UruNfQJDZnVxmZUfKO3h
	 097gOG8nEDuYCwEnar1EyWBnkTugQeivYCweS8mxZXLJJ5UC+W91JBzPh1g9qPFCu3
	 z5Lnd4BZEFQ5A==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D882164C3C;
	Wed, 11 Nov 2026 09:21:52 +0800 (AWST)
Message-ID: <cb3d9f50467089c6b13ea83aeddfb032c046848a.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/3] ARM: dts: aspeed: ventura2: Add LTC2305 ADCs and
 GPIO line names
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ryan
 Chen <ryan_chen@aspeedtech.com>,  Billy Tsai <billy_tsai@aspeedtech.com>,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, 	linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 11:51:52 +1030
In-Reply-To: <CAF7HswPYb3hOWA7P-d1zASvd1XzaVeuBkoqz5nXHuDeEAXDhrA@mail.gmail.com>
References: <20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com>
	 <245d0e9d4043c0957716a6a32985b6ea5a8cb9ef.camel@codeconstruct.com.au>
	 <CAF7HswPYb3hOWA7P-d1zASvd1XzaVeuBkoqz5nXHuDeEAXDhrA@mail.gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-10 at 16:44 +0800, Kyle Hsieh wrote:
> On Mon, Nov 9, 2026 at 10:41=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> > On Fri, 2026-11-06 at 11:08 +0800, Kyle Hsieh wrote:
> > > The LTC2305 ADCs use their internal 4.096V reference, so no vref-supp=
ly
> > > is described. Patch 1 therefore depends on "dt-bindings: iio: adc:
> > > ltc2497: Make vref-supply optional for LTC2305/LTC2309"; without it,
> > > dtbs_check reports a missing vref-supply for the LTC2305 nodes.
> >=20
> > Can you provide a link to this patch? I am yet to find it on lore.
>=20
> Sorry, I should have sent it before this series. It is now posted at:
> https://lore.kernel.org/linux-iio/20261110-ltc2497-vref-optional-v1-1-35c=
9657f3c0f@gmail.com/

Thanks. Can you please let me know when this one has merged?


Andrew

