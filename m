Return-Path: <linux-aspeed+bounces-3244-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AD9FC6167
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Jan 2026 01:01:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4djj1Q6lVRz2yFd;
	Sat, 03 Jan 2026 12:01:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767306985;
	cv=none; b=cGWgKv7i/v3hX+WBzLP/+W+CC/9pFb8qXM2scGQ8jSH9Hj5i8KpQSAIiZ2Qg0JpJ/IcxGmtoV8WDCrfr9U+P1y9dJQ0Z8LOq6oa9uO26MLZiuxzcnczB7jZq5u8ba4CdWiO1gdj8UcFqW2StdWiQM3chjtaQuAH3/xbaEDK+phQJpQdIzT0zOgeXg13jBvwQ7S8p1L1Cji1Gz2O0+s2UytFjFgkvnOJ8qT7XTQWiswIjAdA+vcAfdoVymxvyqXnZYBXGkSQIqu+9sWpYQyFRgaPajZm8AiJrykBAeNfxyAJA/sbLv/HNA+6spBWE3xlyukyomzeBD4bhsNP++v7Q6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767306985; c=relaxed/relaxed;
	bh=QMvcHOsvbeq/KIs3IJ0EOSwRJPyItWeiXV1rTu2E8c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqLDHqLkoubGwHoLrDxosBhAzDGrz3la/7PJ2qyfN5PCVcAUn0OHAME9X6zs1WzpLqeCyA0CYE25QeGnN7Ix1nYqoMRIc38MlLIJyCkSLNI6RQkWA2h8oXq2PhqTOiif4dhdGOZ6X6OVjZjmUqfwY8ovdooDQdeQUvMFd7T6MjoR1qxBoHmfT8kF2wymQ7mXAYrlbzYCVwIBq1fYVXiVIb+Qx5q1Lg6EnDCYCcSqVSXLW+JfI+jBwNU/d+N0uLCd/YNMEPjcUKAv/dqzrym9g+Gk2Q+UpFnoajaZD4I5jOeXYxf/CNRRjcxMeYZDSC6eoR2tKwNLLAn2iyC+BkBTSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iPFW2Ojk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iPFW2Ojk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dj1rn0k5Cz2x9W
	for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Jan 2026 09:36:25 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6FDB041AF0
	for <linux-aspeed@lists.ozlabs.org>; Thu,  1 Jan 2026 22:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514F4C4CEF7
	for <linux-aspeed@lists.ozlabs.org>; Thu,  1 Jan 2026 22:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767306952;
	bh=QMvcHOsvbeq/KIs3IJ0EOSwRJPyItWeiXV1rTu2E8c4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iPFW2OjkDUHTshzwy5iZrPT9cuPNdw7BLkUBetmleByjNDVFJI0R5NI77lzRdn0Zg
	 1OSOSGsHWWBN7i0ybcyrvT+L0f795oGsXzbeIOS/3T9yULI2Cvg+3SOXEvNV8BykWa
	 XyyUQfCJoCL+s2bMBfQECwQt1eGAfVlwaH7pUrwvu0X4iq1Qx1IhJIecwGZkVsn1b1
	 XJ9/TFtOd+i8aAlSvEW4IaYX1GbP5PcNEFPkJ8Pd5b/Gkyqaz79M8zTVByL4Fc9TFj
	 MuL5L4/s0+aL5+VYtsvjqny+PUZEWtQUIzNE69tkAahD/Gdo/6BykV5XfjjdvzZjPX
	 DElUuHmIx9MYA==
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6468f0d5b1cso6905051d50.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Jan 2026 14:35:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLbATiAeoiMLCqCgilKTQPcNqvI7sNKZn1C7SupwvIbtamnvrDZguaKroozeUZR+SMfOD5FI+UO6u+8WU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxflkvwCDQusiN+UXFmzLcmqZkcUX4afx+fwS+yLzqYGbvryjgi
	3yZtFw24Yqs/ElF0b2nrJTtjdP/CAOraw5uSO1I6gQFazFtvNhpyC22WvxE2L0dZ+xCKo8jS2WT
	x3ZusHca70z2RzUj39wjT/UyryQOUhkY=
X-Google-Smtp-Source: AGHT+IEbScPl11Wd17XFYMap12LvzWfJ4p/Vjq8yPw63OOIA+tKxG0Z0war/aoElpBRNBkuJ5ynYi3FD1FVnyPhQPxM=
X-Received: by 2002:a53:e01b:0:b0:644:6c45:4ee9 with SMTP id
 956f58d0204a3-6466a8c4e2emr24775256d50.39.1767306951744; Thu, 01 Jan 2026
 14:35:51 -0800 (PST)
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
References: <20251219-gpio-of-match-v2-0-5c65cbb513ac@oss.qualcomm.com> <20251219-gpio-of-match-v2-2-5c65cbb513ac@oss.qualcomm.com>
In-Reply-To: <20251219-gpio-of-match-v2-2-5c65cbb513ac@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Jan 2026 23:35:40 +0100
X-Gmail-Original-Message-ID: <CAD++jLnfDotbsE8fz_xFK4RhbAUO_PXrDECgT9mgnCO3Ek92UQ@mail.gmail.com>
X-Gm-Features: AQt7F2rgsNyQ_sXrUoBKmwhd6vUxSgOicBOQWjF3aplz2un6xPpf3QX8VXVj1OM
Message-ID: <CAD++jLnfDotbsE8fz_xFK4RhbAUO_PXrDECgT9mgnCO3Ek92UQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gpio: creg-snps: Simplify with of_device_get_match_data()
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

On Fri, Dec 19, 2025 at 11:12=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Driver's probe function matches against driver's of_device_id table,
> where each entry has non-NULL match data, so of_match_node() can be
> simplified with of_device_get_match_data().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

