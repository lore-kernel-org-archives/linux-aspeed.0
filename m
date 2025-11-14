Return-Path: <linux-aspeed+bounces-2904-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EBCCD4F49
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Nov 2025 04:10:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d73bB3XzYz2ySq;
	Fri, 14 Nov 2025 15:10:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763093446;
	cv=none; b=Q6Ty8JyswJr/0OFcWz2wCVWFIVJZNFQxM+czu1r1A2n+FOBaJ3OgMwCUrAtJ6vzpK/b2+I9eu6F2VPdj+0nCZKNFxfjzKBfP12UxH/wadbPCknIl5GXBhjSqtQtAt05WW8LWPBkliEnnUJCLhSiPwruxEr8ff4hKI2M0X8zxREvKMqQJQ0T4NbvaXOKShjkeFNqAst4QfmMxAcWDbuRId2A2xz1VzLtgAEIl66rAFPw4iSsJ2TqHDhKoXL5F9M6NGN4xbdXW33rEecjdNhgzha9pO1UmPcgR2f7wy7sI7Dn1ftCB8c9Qa90AhYd6hu5cJhaT7uuiNVB2sY03cZMbig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763093446; c=relaxed/relaxed;
	bh=QtuHGVXdvxA+eHBB8lQL4h1KqWaneZd2wuVLpQ3gaXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vhc1d2WxyZuzinm7nDgzmJcIZH/XT65nW8gB1LlXDw9Q+LVaP+Vel06slRzFQjnUX0EwrapDXs805YmkHQmQiSyz6d0M8ydcfYKyd+j2yG2YkCyzxrhHS0hTixdwv5Oy9WM3ZkWwt+xihn9K2uExIj4EIyor9X6gV1J6N6Rjm8kEA7tor71ODSGMfqHYj0yrI5+RIFhB+xbNaeCofj452om4JPvaZuBjfa71D4eq7bEp4O6jeVyfdLUM8JEv9o30uyVRxvp4vAnsU4/7147Y4m3gOtQ1HtnlSM6CuWYZLaPMaOsjByoEo/so+x/7829K6/HMgIdAsxd9xQIfiZigSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NBqH8na6; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NBqH8na6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d73b9711Wz2xnh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Nov 2025 15:10:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1763093445;
	bh=QtuHGVXdvxA+eHBB8lQL4h1KqWaneZd2wuVLpQ3gaXg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NBqH8na6t0YDaoGvhOypw+y0cGSiDZzvkOP1vNYbLDdsjf65755feM5aRqtVfz4/O
	 51wN/N2n+KxwL7SMWdtBzckHBOtbpNRtUiED+UfXF3tEaZ986gwqEGr7D+lYPbe/41
	 9yqdyzKpwcJ3Pn4/GdJ8dML8ktTpSL5zsbYBDr+Da3AGt2faFyhZpaqnm+501u+bxW
	 UAbHxsdxzeK7VOMEzmSihSY4LtHBJx3JXuSak8D6uWtXZLwqqTcKaAK+mKoL4vA/W7
	 fKqIZkdfM6nVPXHj8nv2bZGpuV9XijHq2PR6d/Qjdfm4j2npCjxr2klaUHfW80Zn2z
	 zb+Mw0XWKTZug==
Received: from [192.168.68.115] (unknown [180.150.112.244])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CA419783DF;
	Fri, 14 Nov 2025 12:10:44 +0800 (AWST)
Message-ID: <580b0c6d979a69ea0c4590b5d9ba035b417effb8.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] ARM: dts: aspeed: clemente: add gpio line name to io
 expander
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: kimi.zy.chen@fii-foxconn.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	george.kw.lee@fii-foxconn.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>
Date: Fri, 14 Nov 2025 14:40:44 +1030
In-Reply-To: <20251107-dts-add-gpio-to-io-expander-v2-1-585d48845546@fii-foxconn.com>
References: 
	<20251107-dts-add-gpio-to-io-expander-v2-1-585d48845546@fii-foxconn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Fri, 2025-11-07 at 00:58 +0800, Kimi Chen via B4 Relay wrote:
> From: Kimi Chen <kimi.zy.chen@fii-foxconn.com>
>=20
> The chassis power cycle process requires a forced shutdown before
> cutting off the standby power. Therefore, SCM CPLD adds a hard shutdown
> host function and triggers it via the IO expander in Clemente platform.
>=20
> Thus, a new GPIO line named "hard_shutdown_host" is added to the

Most of the Clemente GPIOs names appear to be styled as net names from
the schematics. Is that the source of this name as well? Or have you
somewhat arbitrarily chosen it? Can you expand on its importance (e.g.
wrt userspace software)?

Andrew

