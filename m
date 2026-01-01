Return-Path: <linux-aspeed+bounces-3242-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC9EFC6165
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Jan 2026 01:01:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4djj1Q3BPGz2xdL;
	Sat, 03 Jan 2026 12:01:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767307048;
	cv=none; b=U7N7pYBp8XQYyFnt589NW8k/9j8eyDg28fRSKoY5dCeXlOY5j2qSp19ErZ3EJsMthahZ0bPsyY/fvPx54wHOOh0ndWOntj5ZfYwNkxH0CJFIaKPPKJDX2nWFlPTgjv6s+tjWvSDKljeQW3ONWXT4TvfWiTiW0QgLcr9AhgG/mj6+aLz/4oLb//XlTHeligdfvxR1eb0fXCO7RzaL/ox4bD+BuDWctX0+WsHLUCkd4P8U3VvRfpBvvaBRQeRxFFboxCCuhMvJgGgJ4f9SxGCcMbk4hbLljCBDB6NVIujXePuUTeQINnv85Lm1zVrOSh3wjmb6VlwqlpzKohR8R4A79g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767307048; c=relaxed/relaxed;
	bh=4NjZxR7n/i3V7hLD9I4rLfeAHHpOdNccUfDSk4/Vc7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Th4BHe4M7PAAscfxQT8mwMVCR3ultgd510XanAm0lY8oxhSEXjSEQKqZxO+NWzDddfFGpQOChR5bR9sXGDey0JkQNRrp5EzEKNXBvfCmyTJEqFz1Kq84qaXivHr8bNFznaRGK8Xr2zNSyfZP3ubw2C3eimcaEkLWebOoZS/vy85sddRSzWWnYO0D2OEsQJh5s98OWckzF/xEYN2WW5K39+VYUY+LPsYvxsRzt51Z1ywZ82YMIAe9hO9wASqM9o4k//cz2hQkUZBgs8Olk/5yOLfUqiHyhd16MMvjrUoz1ZW8pvgwG84jbaIw1OeKb2oXNI0C1hpRo8sMokpkxKUKyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ldleX95I; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ldleX95I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dj1t01dSFz2x9W
	for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Jan 2026 09:37:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 24458600AE
	for <linux-aspeed@lists.ozlabs.org>; Thu,  1 Jan 2026 22:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15EBC4AF0E
	for <linux-aspeed@lists.ozlabs.org>; Thu,  1 Jan 2026 22:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767307045;
	bh=4NjZxR7n/i3V7hLD9I4rLfeAHHpOdNccUfDSk4/Vc7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ldleX95IA/Rhvnga9zhFQWYGX90TGGbu/MedExFGoLKzVm9VARMh8b4CPjo/2oO4z
	 uKiJMDiRPe8vx9Ae2im5rgASh7toMyvrp+3s8uV+b4s2A1bo2kIMVdy/np8WxJ0nFF
	 jpnUfQKMo0eZWT2s3O6705wXXVNYU0bfvpsidNKw5cKrp6aHSDERDTXmzczKXpTR+H
	 tz2TLU3He7TUxiY7sjfuAbq5j/4OEo5k6fbMpAy+E9hoj9Y5cZ0GOXDFSkbrB+HL+d
	 0Z0ONjr6g5QbbGc3ZTShvcyOdNkauf7dciFEh9mQ4iBPiJyTohSkKFEEp8kOKXbz2o
	 SyoTt/wvt2k6Q==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78d6a3c3b77so122085497b3.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Jan 2026 14:37:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpPynjf7O5r34C5Zu9cSU/sqzZ1OQIip2V8HXmdgWgq6x0CGa/JI5Pd5NglgrX9y/ErZp6jza9GU2p8NI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNdPakKgvgK3QCnM8+B6zdL4cmVbsO0lkBu8ruhMEsiT7X2Bgm
	vWY2+AfxAZZrAW2CuK05rlyNiP+02ec/WtEqQ0WW3tfLBqeE9VszgQiM7g4pNcMSKVk1VTZX/Wx
	QjXcTxvtZEw4nDBF33bJDiEn2fHmjWr8=
X-Google-Smtp-Source: AGHT+IGxfFDsTCRV20/MitXOg9IYsjIgYuqKye3DeOL8wH03xNmqZuWnyqOfWZ2rc2d7AeH+J//qkrFfgP8RZqpfLp8=
X-Received: by 2002:a53:8585:0:b0:644:60d9:8661 with SMTP id
 956f58d0204a3-646632e1cd7mr26165537d50.45.1767307045252; Thu, 01 Jan 2026
 14:37:25 -0800 (PST)
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
References: <20251219-gpio-of-match-v3-0-6b84194a02a8@oss.qualcomm.com> <20251219-gpio-of-match-v3-3-6b84194a02a8@oss.qualcomm.com>
In-Reply-To: <20251219-gpio-of-match-v3-3-6b84194a02a8@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Jan 2026 23:37:14 +0100
X-Gmail-Original-Message-ID: <CAD++jLndAvhQC_pxU7fU2DgL2HyosfNQqnTxVXrm4uLNK59y3A@mail.gmail.com>
X-Gm-Features: AQt7F2pIVe2by9dHgGDwlRyH8hysFAWe6pLdQf74mH3djmHANQGvVjg82Ayxg4s
Message-ID: <CAD++jLndAvhQC_pxU7fU2DgL2HyosfNQqnTxVXrm4uLNK59y3A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: zynq: Simplify with device_get_match_data()
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
> While changing the error message, switch to dev_err_probe() so error
> path is a bit simpler.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

