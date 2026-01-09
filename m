Return-Path: <linux-aspeed+bounces-3267-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9282AD232C6
	for <linux-aspeed@archiver.kernel.org>; Fri,  9 Jan 2026 01:15:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnP2g6WFPz2xpl;
	Fri, 09 Jan 2026 12:15:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767921307;
	cv=none; b=MaDNvbQcjfHaLdsel6FDQ1IUTCGatGMQCD09zDsdOH3XvCDOMp70tCaC6L0Hv0gJt0dUJTizRGHpYrGRP06XMVK8u5GSjbC8oc1PalLH6xGNgPVzujsg+/fyH0QnDDxWZEOkWqafj0X7wOw34urLTWtCWqvV7OsP0fXcLUHrpK0X5LZB8ioHIZTobQJaAODTTNE+i30mdE/ScGnbKrtj5GkougJBo8BTOAGfytWzMpN1UeMcZHNNawAy7EfHuD2solGr5Qzzd4ip26BEqlsMEdmzW12sKt0AW5Uw0G2QdJ5bm+nfniZOJXcvfw4klNRVFgirPvZi/GdUYPHVohcing==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767921307; c=relaxed/relaxed;
	bh=q3E163uI3K5tcHbZm92cmc4Zh/3hUlsioPVQnfeSCfU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2qcBYictASdJwuZFr3fFhwebIznidK5Zlz7mrrcqUypLkbAADbwu+XkeM8NkIxURgoUjlXCVf+anXoK0za8tMzXVnoe0JXkRTFPsKVhA8I2MBEdhEQiL/qN6KPFcVMti8H5INUVBEheWw8pq5nByIw2h0md3WYYm+NCv2lotdgghHWRhjWYJ4pdvicpzUVdjSWipQUg7ddWZzLSl7HI5Hn/JoGgN1SGUJzfnVJDAlJeY4MLXc5WAIfZMg1RFKCaMZ3S4fPGwVwPF8LUsEQxmO16+qLePZqaU1v3BHC2hVYA64r0XB8o34L4fVV56W41b6+LmqAVC6RQi4BeO+abyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LRIkXzIr; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LRIkXzIr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnP2g300Jz2xFn;
	Fri, 09 Jan 2026 12:15:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767921306;
	bh=q3E163uI3K5tcHbZm92cmc4Zh/3hUlsioPVQnfeSCfU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LRIkXzIr3s7sm5+72Xzzm8SjVCwh35y5UgkNyHoV+JM3WTIw4jCZ0lDvwCm+aPN0e
	 OQgFLIKM4BqvXo0NDLP3ls7rFqmmBeyhe3rnpJu/pg93332Xw7ohD6Pd9ZJ/hjBMlU
	 PRjuB0y52YZmZ4+MH64SFaK4M4cz7aGbppx05rQHhJZ74p/FIDNPTDWN0K4c0V0JgD
	 wiw55qfCcmMSwZ6OUkuCfyWIamYz6ikXWYRWi0kp9pEh45rf87ky9C+o4xQpR/1WKQ
	 AYxvTEvGFmjwoc8wcX4fj2oaw7HDda+hVz5pALgfHA8ZdaPbXUesk0VOJX+gMBis+I
	 YapIA/GolbjCw==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 50B3D7E142;
	Fri,  9 Jan 2026 09:15:06 +0800 (AWST)
Message-ID: <0671df0ea3568056e4d46112c4c9d132c64aed01.camel@codeconstruct.com.au>
Subject: Re: [PATCH RFC 02/16] pinctrl: aspeed: g5: Constrain LPC binding
 revision workaround to AST2500
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 linux-hwmon@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, 	openbmc@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org
Date: Fri, 09 Jan 2026 11:45:05 +1030
In-Reply-To: <CAD++jLmNGrDt3_w=DFnBnjEuz3LN-=uc1o9KHv1j=4gbGPoPQg@mail.gmail.com>
References: 
	<20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
	 <20251211-dev-dt-warnings-all-v1-2-21b18b9ada77@codeconstruct.com.au>
	 <CAD++jLmNGrDt3_w=DFnBnjEuz3LN-=uc1o9KHv1j=4gbGPoPQg@mail.gmail.com>
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2025-12-31 at 22:37 +0100, Linus Walleij wrote:
> On Thu, Dec 11, 2025 at 9:46=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
>=20
> > Discovering a phandle to an AST2400 or AST2600 LPC node indicates an
> > error for the purpose of the AST2500 pinctrl driver.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>=20
> Also pretty obviously correct, can't I just apply this one?

Yep, I'm happy for you to apply this one now. I marked the series RFC
because it's a bit of a scatter-gun set of changes and I figured there
might be more feedback than I've received so far :)

Andrew

