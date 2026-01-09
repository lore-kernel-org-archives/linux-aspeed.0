Return-Path: <linux-aspeed+bounces-3274-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB4DD277C1
	for <linux-aspeed@archiver.kernel.org>; Sat, 10 Jan 2026 00:27:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnzxP5JCpz2yFm;
	Sat, 10 Jan 2026 11:27:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767965686;
	cv=none; b=RcZu5nHYqEL3c35Yv2Je/tLoEFwY2jBLw/eEF48Ej51Z43OugH7Is0Y+vgTVO/2QBXTtG2B7HJnrNH4V6ps1jYPBVhhvoiW7D3wHWQ4QL9YoBFqo/WR+sriXyxGqUoWB/R7a6kngJUWAQ/r7pg251hNESibZZyPTeXvYkMLxk7dDe4mKfrWfPP9tdtOcJEd1/3pkTnO8sSWKWmPxjdSHCn/BGjLLP7dWGnm3/UiqoKId2dBjm28ALLi/iwM96d3tcL8BNVEGzHRYpRd1fkdd2VM7B/S1ymDgGTLfZC+Y8YmMg+jmX3ZX7nNjJn2BHTjpOyMIBNQ2qOZfZF7z0+9vyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767965686; c=relaxed/relaxed;
	bh=qWzvjygcuLwzEIaEHIXEz9SaaWzpXF20ANBBtTSJsrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crzjRMz0Jdol0AQNRAeNn5YUygOEUIpDYVxkaWxb8fizjHPwFQHPSBv/DCbh8LcBWhUN/D/bGgJEFHN8wtRtZejMh0MXsO+jZFYRMxoEQXV07Pm9herUN29VM4w1HP5ZbNr+kRtkZEHAGSNVEdoerHRiXcmgUFF9WOcfU42lOBW9k+Wbm6FhHkXTL1SNBz2fQzIqaEnL/SDUZcDwabaoVEQF6IhGxy/eoBKjs1BAWai3//UVKlOLfVHzAZl/5iWp3Ud5fdXyF1fxcwc99Evi6YYWs7Gf6RtxMzaoOnvC7ExR/SUzeHvGJi/Jh7SauAuBFMiS2uj6JE1i45tQxOvGRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pXlvPg28; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pXlvPg28;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnjS60WCfz2xP8
	for <linux-aspeed@lists.ozlabs.org>; Sat, 10 Jan 2026 00:34:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 36A70403B3
	for <linux-aspeed@lists.ozlabs.org>; Fri,  9 Jan 2026 13:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1062AC2BCB0
	for <linux-aspeed@lists.ozlabs.org>; Fri,  9 Jan 2026 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767965654;
	bh=qWzvjygcuLwzEIaEHIXEz9SaaWzpXF20ANBBtTSJsrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pXlvPg28ROYATVopjWOzBg5vR6kEbc/rx+T7qI0QvP2SRipywjvuMEbt9KtaaxSYT
	 xe41Bh4rKblR4UC3fgonuJIUAP1Scoti7w7lySstIJj1IljhPDfFwqgyMSZ5hkLhkV
	 hDwAKsaAklZBG6nfOBwnm/d727a3L+w3tVOlc3+2qmrFxxXMG9NSreOu1PRx0ID/T5
	 Sk06jar9d7TVaM5zvynCh40hUwRb9JggexRF+5nrKi96yMZ7+CqICc69PeGzLkg8zg
	 xqItjYKcEsy1nJZ42n/xGyGJudNUYjzO3ZEDujQGxtFPI33Kj01chsyagXJ1g1FxNG
	 AfDuGE1XUDtzQ==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78fc4425b6bso43989007b3.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 09 Jan 2026 05:34:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWx2nlUj7exZi2DoEtckmD0EqCPK5wMMf/FsvL2qm95tDo/Zd/lU5sXiQllRt93aIbTEwORVgaPhXwJe8s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzWP0bu/WsJH283Z4L0ykiqrTpHbq0I3rCnf639Oti43PIsXXxf
	j79rowAkU3OzntvwZNHVzJPDN8vRw0bztIqcNQHeRy67J6FX+5znPdruotYZ3nuWWs8OyxnMyDA
	eQrcxRtxpIRyKFtm2Y9Q50nZEGH0qKro=
X-Google-Smtp-Source: AGHT+IFesI9TgGv8pGaGDvBFA25rqPyYSWQ/7ybS7ei3jmEtj0pUiPwxVn1yVv3/z2opC7z47lsPIXjgx7XM38IPl5Y=
X-Received: by 2002:a05:690e:118e:b0:640:d31d:6ed4 with SMTP id
 956f58d0204a3-64716c67b91mr8452143d50.51.1767965653394; Fri, 09 Jan 2026
 05:34:13 -0800 (PST)
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
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-2-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-2-21b18b9ada77@codeconstruct.com.au>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 9 Jan 2026 14:34:02 +0100
X-Gmail-Original-Message-ID: <CAD++jLk=9P3SaPgeuD46O_-D5xTKXiefRKenq2w8HVcv5rUdxw@mail.gmail.com>
X-Gm-Features: AZwV_QjuVx1piuHcehHbUq1Xzc5Kt25GKCC_RKdVxx8gfqJ7sqje1Z1f8fkkuKU
Message-ID: <CAD++jLk=9P3SaPgeuD46O_-D5xTKXiefRKenq2w8HVcv5rUdxw@mail.gmail.com>
Subject: Re: [PATCH RFC 02/16] pinctrl: aspeed: g5: Constrain LPC binding
 revision workaround to AST2500
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 9:46=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:

> Discovering a phandle to an AST2400 or AST2600 LPC node indicates an
> error for the purpose of the AST2500 pinctrl driver.
>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Patch applied for Linux 7.0!

Yours,
Linus Walleij

