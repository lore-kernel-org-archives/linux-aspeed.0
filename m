Return-Path: <linux-aspeed+bounces-3246-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF490FC6166
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Jan 2026 01:31:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4djjh00vwnz2yFW;
	Sat, 03 Jan 2026 12:31:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767217055;
	cv=none; b=R2HZU4ulDjgMFao8H1jkA/S6mdwlUs22QpbUIJUI4GOfItea+L9Qe6WZ1fYDI+/iZA3g93uFAJG5YeZJDkUr4pHJGvSD3KzxrwC0HIg24O+crKLgo4qzaC2O6uIli2t3zXu8MgR3P6zNE1ZtfgEbE9MqcgJgIy2S3cNWC0CCrttqS2Hj/tulnF0HidgiZiQsaF3GnbtD2mqWWzyZ4+tXVZ+05hDWy9SIQdgvM/llwAXPT+06xrhrvI8zvezwMw9qTWR2gYT4uNyxDfMOS0PvyxgDXgt43Bu3WSdwtCMbH7cq8+ZG5ImgXPUAOiBmgLjgiipIoQ/kEA65U/7ozBI9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767217055; c=relaxed/relaxed;
	bh=3Rfnf2qhGGwgV00DUgX+jw89Q5Q97DzPe9bYdiAb1ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUalhNjHpz2SX6NE3fj0VrnJ/ra6fj/vypk2q7pjXgVdf1YBFMCPXrY/CxWDD5Ty9ujK/0acUFGFm8n2xHpk2sUjLMB3ueXp3JBoBEkH+d3GuCKBQiWYEXkdpGhCDfQTx1ujhX5uFHJ9oIEjub+vjc3EEjsx81IyA7ble2RcWMaX6bIIgT2bJJqHkEwwa98Nr5QbwuE2m2F/t8WhkytBUqJ+lsg2UckpPZJ+Ic+TjH3eN7iHuMAfb2coMXVSQK3OTn9M1yPR1ASmBnF5ZE4sJ//QZRlrcfeRQ95Jyp66LOMAmRZPtJH9WajCtKgWYnMuzJ3uSX/gH8ZkP0tNk8IODQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S/myJmuv; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S/myJmuv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dhNbM0kNMz2x9W
	for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Jan 2026 08:37:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7941860008
	for <linux-aspeed@lists.ozlabs.org>; Wed, 31 Dec 2025 21:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EF1C16AAE
	for <linux-aspeed@lists.ozlabs.org>; Wed, 31 Dec 2025 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767217047;
	bh=3Rfnf2qhGGwgV00DUgX+jw89Q5Q97DzPe9bYdiAb1ps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S/myJmuvkQhoJ8EppRf3vex1oHqN6qlqOFLVY9fq6nDRgajD26aH7kRPXmgv928XN
	 DF+TI78MG0UkXzZMdQuw/GlDgWSTvvxshjuoWDv9HPqT/ygN9fSm4tM6/4gtAfbWRo
	 QzgG3od32ACcdrA4U/CqlZorWWrLyM+hVKKc9JprOQAISIoIWyWLrac6n3tEKlvdbz
	 pn7SDd/cIIVAUBaCaNAtbKkHkMk4EWxb3ubqdSGLJYW7BHJG77tQL9PBBKd5n9kxil
	 vefx2gkquaNmsHtp/u9YwXN07/1/wFU4m8CwszxqBuN+8dVBrt7VZWgJ48dhsHZj/v
	 RFgKGQWveyeJQ==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64455a2a096so8918798d50.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 31 Dec 2025 13:37:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSu6u7M01NbSjAmxBRJjLzl5gKdBozu5rZaHmebLQh0YS7DrUhvtSngApu/7H+bdNvBEsMddUaw5cOwxc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YygCSn3Yce7ifXMPoAEmHycSmIWipv4hWZqXNnrcTkwI9WXcyEA
	z3hpW06DtbR/xm2ZIEmIU40YereaLwYnDssOabcYCMmAbsw9q1S3uan5RpQm8u1XWJd9mhHCyXI
	26MWsZOtN7RYo/wKih+ySY01R09Y4/FY=
X-Google-Smtp-Source: AGHT+IHHeH8zJG7rfiI2GFfedkzIC0YK/SbYafxSnkK2MFdRLnSCHEYor5QZDiE7b0zGilhY27fuPDjyGexn5uPgcoQ=
X-Received: by 2002:a05:690c:3803:b0:78f:984b:4bb5 with SMTP id
 00721157ae682-78fb40c5f09mr590051547b3.64.1767217046540; Wed, 31 Dec 2025
 13:37:26 -0800 (PST)
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
Date: Wed, 31 Dec 2025 22:37:15 +0100
X-Gmail-Original-Message-ID: <CAD++jLmNGrDt3_w=DFnBnjEuz3LN-=uc1o9KHv1j=4gbGPoPQg@mail.gmail.com>
X-Gm-Features: AQt7F2oNijhkSY2l2xLUahhHBTqPWX5BBKamnMGV8HdX2c29O6a9KTnJl-DXNNE
Message-ID: <CAD++jLmNGrDt3_w=DFnBnjEuz3LN-=uc1o9KHv1j=4gbGPoPQg@mail.gmail.com>
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

Reviewed-by: Linus Walleij <linusw@kernel.org>

Also pretty obviously correct, can't I just apply this one?

Yours,
Linus Walleij

