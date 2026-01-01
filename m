Return-Path: <linux-aspeed+bounces-3243-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF99FC6169
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Jan 2026 01:01:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4djj1Q69tVz2yFb;
	Sat, 03 Jan 2026 12:01:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767307030;
	cv=none; b=LwkUd/wjG24gQ0jPaA5pbMWacg44uVHrUEGPzwHgf/Gizlr15q5nCo/BkdZdJ6slVBddQKD615i39CBCzGYXche5grXPS/K/9Z+kK85fZLtSPr3hzX4PtanTUVDEq27tNmF5tzqsYTS2scoIJS/7v9isoY3QgrS0Zt3914v0QnAN3n/d5zORbAniYsGifr0KQ0MEG+QsoKWQLx2Lflvc35z9bRnYM+CHeyHZKeJ/E2XfY/Y9DGAg7PjOPUcl3aNZDlXmmvb4oAR0UpdCwZG8AjItlIMYqhOCglqtGAnNOBUHSfm7WlaYQGGjIba+S7sZA7NFRF3TaVtyG7ppruHt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767307030; c=relaxed/relaxed;
	bh=zFPbOYoiGK2YHEkPa6hnUfO45Q+tjDmbpv/dwRaLQsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btf1qAfMJbvaUYFJmK9kBbovzhdI4oF4XMw2rUs+Zye/lZVTENRH470QItNmw1vmGb5tUjtAuBKXHp7a2qfjELQSoQMeGut3xiJpzvoItrMTOwGTRnDhzoQC08+oCbr28tVZAn2r26Q3x5EcQBRAMVG3jdnL+iQPJA0hZrtNT1ViIrjvc/lhGUXeRkRp5k0QopoRB5XHfgIa+vAFdBqFX2uidz/Jb4dngoGkrxDKuFfx22D8zkiqzttl3qaEweptG5YuYa0jdq3F83nd9g0cMiZBdI47w1cB4KmYYnH1vj4zhqf/Rd/zKe6QPlesKSrkswc3/iaoxoJneM/xXiBIzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kl4pgeQT; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kl4pgeQT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dj1sd5phxz2x9W
	for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Jan 2026 09:37:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BDBE3600AD
	for <linux-aspeed@lists.ozlabs.org>; Thu,  1 Jan 2026 22:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A8DC2BC86
	for <linux-aspeed@lists.ozlabs.org>; Thu,  1 Jan 2026 22:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767307027;
	bh=zFPbOYoiGK2YHEkPa6hnUfO45Q+tjDmbpv/dwRaLQsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kl4pgeQTMcNieDd0E9vjK0PVEZAl50YBJtlvRVdNDWMxg7YN8mqBWtoYLiY91IMRi
	 BdXVr1OyKkuUtXwyc9LJpZtj1d6UUH/o8Mg6pvaHUk+5Dbex2dmg5YHvJp42+5K4EP
	 pB2Yv6wpLhNBBuu9UBgbxxW8T8hCh+NS/C1Wbr/xVwmfm/re3MF43VA5FptGVfY0fa
	 UIa3jTgCrqkr6g/v4LgRdhf/+L+Yp4SYf+V79kXo7SKh4hZRaaHQOEEI76o0bm+Z6O
	 WeBWvuD+es7Z46FwOPh2OmjYP2GQzdh1XD5xyydWSA8e6MwSjpUaHB7+Y/yOY260YL
	 8Uz4Jv4EQEhQg==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7900ab67562so45980197b3.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Jan 2026 14:37:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCPGtihwWEmzLb2+Kn5+p/vJWFh4gn1nBKxtjngSpf66s8OAkd/4tECMrigaYHxbuFYxKOfGlun6QBIWY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8BNDM6wIlG9bEllk8Qmi1NDwI1Qnzt6Btaiq81aIiAnHiItVz
	92jgMTB2fCztjOc5T2/tO7dCNvD6hI4Ur6EqGUswaz5/moGPPNuP5qTAMnimi0gry/DzjjVxa1v
	JnX/Les/hlOFCNlc+OfyiN/yhtC7K4RA=
X-Google-Smtp-Source: AGHT+IH3rHX+MO0pndYIAY3BMyel2/PmtkDfaZjjQgMxYMPVkQt2SYFlCdvDRxCbn4W4GcVq5UmB1hnOFsctyFssdo0=
X-Received: by 2002:a05:690c:6f8e:b0:78e:1aa5:e970 with SMTP id
 00721157ae682-78fb3f5c183mr344105557b3.31.1767307026776; Thu, 01 Jan 2026
 14:37:06 -0800 (PST)
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
References: <20251219-gpio-of-match-v3-0-6b84194a02a8@oss.qualcomm.com> <20251219-gpio-of-match-v3-2-6b84194a02a8@oss.qualcomm.com>
In-Reply-To: <20251219-gpio-of-match-v3-2-6b84194a02a8@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Jan 2026 23:36:55 +0100
X-Gmail-Original-Message-ID: <CAD++jLnoxse5RrX0-m3dNNa-B_h0yHCw6H24H14Dkts5XwYCDA@mail.gmail.com>
X-Gm-Features: AQt7F2oRBtplfDlu9a7oL72YgDu3OW_f7prR_jrtoZC5RVkWzk3Mu6ddY4BWlD0
Message-ID: <CAD++jLnoxse5RrX0-m3dNNa-B_h0yHCw6H24H14Dkts5XwYCDA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] gpio: creg-snps: Simplify with device_get_match_data()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 1:13=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Driver's probe function matches against driver's of_device_id table,
> where each entry has non-NULL match data, so of_match_node() can be
> simplified with device_get_match_data().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

