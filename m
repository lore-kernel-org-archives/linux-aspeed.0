Return-Path: <linux-aspeed+bounces-2060-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2685ECA0FF6
	for <linux-aspeed@archiver.kernel.org>; Thu, 28 Aug 2025 20:47:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cCYNw4JTtz2xnx;
	Fri, 29 Aug 2025 06:47:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::234"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756414032;
	cv=none; b=Q6Hci2OsYvOXBhH416KgexeISVb1XrevJLlOxIG3n4iyUv00efGIkrHJHgIDvpmf8eWXmN8/XxB6afVpIvXqpnTsV08XTOXNo1VV+zysNu9fyYY7ZMCaxbaiu1Xf3r/OIBXC5wJs1ycAzGy7dGU00wtHnwxsdrcbSQEEpeTvqJgWo5Mufbl5TLn5C2oXd/PzrH20/6+sdj9Db4Gth4iEahjH2bxSDDga5hVnItFXBsuqcAeon9tZ3ghHzqBpwSlybWAckgS/AHKNgfCVQ+gXff+Pd+hiUScALv1DpqBdhvnjD3CAko5aIkHmGNE8RPXiKfG8qBTpXUjAgyxiVsExhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756414032; c=relaxed/relaxed;
	bh=yypyaBN746HsDrUzE1kCYfLJaG9FQJercS2A7aMVfV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/BdaFLy1XDnpCAlY7rfQ7wL7xWDo/KZZVRGktHHk+WwHCp9Hy4wWOjaZD2dhx/jbMwBvxa2x4DQ0YNErK2zD/gkrOKTFBLmMHLWj3bsayckhA2WQWtf9pimtlxvXXFQeLL2n8q9TxBrIqks6xDJcOr3TVkoJvka/KysghmQgUou+PQ9b8FQIPr0FxBF1J5ufux5VwYEdqrDnMW9oLSSzrTG4JVV++ukpuaTr6kkdg7eib/zroqoX3AEK7hOAT0KGqCToWHHvZJ27cqOB5wFRd2m6gWXoK9OaUryS2Y61ZaOmzRDyBGxw/U5HI8ZlxkUAL6HYvCQX/0AyIux3ufw0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YS+DCWsK; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::234; helo=mail-lj1-x234.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YS+DCWsK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::234; helo=mail-lj1-x234.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cCYNt4BV1z2xlK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 29 Aug 2025 06:47:09 +1000 (AEST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-336b63d2e56so1114691fa.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 28 Aug 2025 13:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756414024; x=1757018824; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yypyaBN746HsDrUzE1kCYfLJaG9FQJercS2A7aMVfV4=;
        b=YS+DCWsKqGX9lwcpyYsEErcCyxFcvsqbqJMu2PhCkg4VFQKMbSxL4QgfE3mkmWD0yX
         AoxWmBwTVmTB7JsK014lujSttoFrQA/CLbPKSRwr4GRSPey7luwy1z9QKQT7tQ0kpqPh
         0ObadyKm4GdHXAkU93Dw5jRYfkwz2EZ7brVWzV4pJ+tvtv0tgtTzC3axkHRzRjtNpUkt
         htxURHyzNwtHxzruKh7NmG/Sm8CubBYishDDWzFN9HnQVfIJzD+R5VWtA2G0kpkY92GO
         1XJB4kLB38SkTJJrkmp1kc8aiUSiIwOwOAtQjFdM/HDeNvTbd5ffdHxNEnirk6CUrXtU
         TWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414024; x=1757018824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yypyaBN746HsDrUzE1kCYfLJaG9FQJercS2A7aMVfV4=;
        b=l+9JGwpQDqhaRyZvG/+nVPLUC8XTG7wJhbeHF2oB7YB+99WZmB3N1hCoqq2ZN/rghJ
         NrXYYAj5PkIZJmwZotRnZ2PfnOjKx18YSn8Lo1UPQoGTrcz0Bz3IkX3WJKMkjJZb/sUH
         1fca0h9x0TnC3kLRAUzeihSd9LGsfcODC6alW3rtx0qxJU5Niv8guGoAUERajoRz85WJ
         A3ZnpRtdet989BVXvKj6qODJlRQRyv/PpNnd3j8sT/H/X+xTmr5cxzVrLDpigVuKtZiv
         dJwJ7zQJ3op04SwGyfU9wpc0++f6utgWqFrd6eIU5Mxg9xspf27e/zPiP7bjCZ5d26Lt
         y92A==
X-Forwarded-Encrypted: i=1; AJvYcCUw646M7zY7ZP2RKbBsuahbREwZLRbavWnkEqwDIN5bbi6ZjdNF5avdqhWc8dWIbYaCcfjE1ir7lR3NqH8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBPS8O/HGORKN8+IOdAT9ysnVdZqXuk82p6dtakzj+P28bNszD
	7XgB+Ni2SJA2VqKru9WOioHDK/TwyCp/9yKoJIKYnZqdzTUh597lMFcPDHkdyk9EyLKQBGEdYen
	JGLWzl3hJo7MOJ00GpusAl2ORofVTpUY15EAnMPxb+Q==
X-Gm-Gg: ASbGncsTcgNrGarDkHtbMPFGWOEyFnzBacULnEgWYXWK3AVgCXYhMxbbs2sCH+GI1zi
	PN1JL92aKlnKHe7D1ubzIZ2JeBD9qKF3gc3G72qb6BQAOjK17bvhRoPvOR2GW2Wo57qrW3Dvl7h
	JebHjH0R7MhniCFb3QTTbNbUGGp44p71I0eX/olO9AdjYE3BtN1N/jqArn4W48rsBeGg7IXBBZs
	4StqWY=
X-Google-Smtp-Source: AGHT+IE2uWhuibXcObFZ5VTNIy6zlok6JnK2MWtwL7cqbL+/SAGd1n7jHXQKxLY98v4CVTQiyLHeR0E2ooltz4RMmZg=
X-Received: by 2002:a05:651c:23d2:10b0:333:f086:3092 with SMTP id
 38308e7fff4ca-33650e704femr56328661fa.11.1756414024499; Thu, 28 Aug 2025
 13:47:04 -0700 (PDT)
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
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
 <20250715034320.2553837-8-jacky_chou@aspeedtech.com> <CACRpkdarn16N9637dL=Qo8X8o==7T=wBfHdXPczU=Rv3b270KQ@mail.gmail.com>
 <SEYPR06MB513491FF4398138F8A52A5469D38A@SEYPR06MB5134.apcprd06.prod.outlook.com>
In-Reply-To: <SEYPR06MB513491FF4398138F8A52A5469D38A@SEYPR06MB5134.apcprd06.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 22:46:53 +0200
X-Gm-Features: Ac12FXzlvTJpPFPcU9uQ_fN2isTkkss2_BjIEzvxJnxhjmRwD11F1FNpCNVPGsc
Message-ID: <CACRpkdbmRpH1+HtW+vbK7rVk6OCEve54BxTAxrUhX631a2KP1w@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] pinctrl: aspeed-g6: Add PCIe RC PERST pin group
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>, 
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:08=E2=80=AFAM Jacky Chou <jacky_chou@aspeedtech.c=
om> wrote:

> May I remove this patch in the next version of this series?

Yes, and in fact it could have been sent separately from the
rest as well, no need to keep things in a big bundle, it's
easier to merge in small pieces.

The only upside with the big bundles is to help developers
develop all in one place and have a "big branch" to test.
But it doesn't really help the Linux subsystem maintainers.

Yours,
Linus Walleij

