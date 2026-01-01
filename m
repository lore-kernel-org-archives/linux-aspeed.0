Return-Path: <linux-aspeed+bounces-3240-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68130FC6166
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Jan 2026 01:01:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4djj1P4CC3z2yFc;
	Sat, 03 Jan 2026 12:01:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767307045;
	cv=none; b=TYIWD+VPzkCjavb6qVW4g7zRanHIzAZ4XC7CfJzA4L/Su8WN1XdNC0SUNhMj/ySwViGCodmPzvCD4MWuy+ghqvNyVz+ckhrtFWYpdgSEMYwzRtSiruwCcmgigiYv5EZ0yWdmtKep5KfgxwW3NU6LEE2v3/cqZ1RyOIUs5xu4j6IP9wHrJNZ3juK5HoZomYqRCuPTP9uakoBRuzdnuAcnYyPVsT35vn6OhLQB1duXZ1ABPaiREZcSVHWz5octwPB7eV/AiFpQqzgJnsbEq0RKGc7wnTNw79RIPE6KG+//ckx6dDEdo3Kj0VpEiNlr8xEYBDzr9v8IlFYu0DBNg69BWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767307045; c=relaxed/relaxed;
	bh=zFPbOYoiGK2YHEkPa6hnUfO45Q+tjDmbpv/dwRaLQsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6jWsNAm8aJRw+6Q/o5Pi+2rQ7sGO4860sUr/qZPQRaVyPagQe3Nb+vOcJTIE6wYWe7Ogyj/N0LZ/2zhpfaqhfM1IwZgbYUhO413/BTTjOCQqwYZ4qAmBdjrbltoVpMAZAtNC3JWodw81g9IRaKQm9vnepcQssYUl0f2HbtEV3yndk/tbIl8eT8JLVR6Wc0YBl31oWYtdOAW9CGIVv0m5rS587fXqb+5T1EUn9t9NA4K/yL/mcQzV37Dk6EC1c52TCOoYLsHbDxI/0rjrObaZ57HvV2UeIkwcmDQ89jIotWPB6BDELMCdOZn4vt7hCr2z16bah9bTD3+os7Fd+Lofg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=D6knG1Bu; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=D6knG1Bu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dj1sx2VXKz2x9W
	for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Jan 2026 09:37:25 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 45C6160054
	for <linux-aspeed@lists.ozlabs.org>; Thu,  1 Jan 2026 22:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F346BC4AF09
	for <linux-aspeed@lists.ozlabs.org>; Thu,  1 Jan 2026 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767307013;
	bh=zFPbOYoiGK2YHEkPa6hnUfO45Q+tjDmbpv/dwRaLQsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D6knG1BuD6qEHVAwPQ2DKg9tTyDVtorlevdSLRckmOa5iIdxKiJii051JNf8yAACg
	 GVr/obGJuSkR/0A0kPrv3oSUVXN/kLfADsbKky+M+TRE4vARsxUK/Eaxl9ob2LKcoJ
	 Hkawuibs9rcWXGzgoBDF2J/+HtC8kzKH+jKB3t37OYIIFOFZkEDhwLm3Wyc/4gwQCw
	 IV6Zx7+Y4dgH5BTebhaj0+Z0bEb2xwXgjRu2FhQICRyhumbmY8L5eLc5ya3MfDVjIX
	 ztWN+sx7EtKFZQzoGdk6w/vppML0zDAeS2H5iBWq/sbTKDcdUSbEmulGoPs+9gYkhw
	 5hmJkSUkwFcIw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78c66bdf675so101121407b3.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Jan 2026 14:36:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWG2ClnZE7S/WH3RQFGsCtjYBQEvzPOSjkdMFmzTuK9LA6knk6jbJtnUvFyZKHfKRIMLCWneMG34cUsc+g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzKgaVr26MQtPg0N5a9LwIfUgxVE3RpWGsKYIpfdycE847uB5B8
	f9QSTP+a/nC7BdF8wT2MlSJGHQR4hWHvRbgvmDcZn1BsxmwnOiOjY/91OplOWRlIf4cqDnrp7s5
	guSccBTGseU4LE4JCCdqek63KqDsqDnI=
X-Google-Smtp-Source: AGHT+IEO5LwtEScYPWNW+HTmyiMl4lA6z8T55VrgRQjoU6dIngv+B6BdPNzDk5TNK4hhdSKTxLiw6rjQ1I7m1uaT2oY=
X-Received: by 2002:a05:690e:4190:b0:644:7a37:e8bf with SMTP id
 956f58d0204a3-6466a8a5cc8mr30736205d50.55.1767307012376; Thu, 01 Jan 2026
 14:36:52 -0800 (PST)
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
References: <20251219-gpio-of-match-v3-0-6b84194a02a8@oss.qualcomm.com> <20251219-gpio-of-match-v3-1-6b84194a02a8@oss.qualcomm.com>
In-Reply-To: <20251219-gpio-of-match-v3-1-6b84194a02a8@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Jan 2026 23:36:41 +0100
X-Gmail-Original-Message-ID: <CAD++jLmhxts7jPoTZabzCUCxjjxqSqgh488UrQk5CgeGC1T1nw@mail.gmail.com>
X-Gm-Features: AQt7F2pUbvBtP6_wDtOSoTk6qQP2DBSKO-EAbAzEKgRoIHXV2ayoPr7YsCnPilE
Message-ID: <CAD++jLmhxts7jPoTZabzCUCxjjxqSqgh488UrQk5CgeGC1T1nw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] gpio: aspeed: Simplify with device_get_match_data()
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

