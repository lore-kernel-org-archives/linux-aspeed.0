Return-Path: <linux-aspeed+bounces-5025-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904C2C982D0
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Sep 2026 23:58:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmCPd1ZgGz2yb9;
	Fri, 18 Sep 2026 09:58:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789625750;
	cv=none; b=d5K5V5xbDKPOl85QeOx/FjtQb31k6dlxbJKObONOyisGwF9iO6oyyRmkUouJvLeic+UFWrTbBBzUE8+uIx7FiReyKthgvykR/2nMomX3BRZhnvebLbedrFWJkLDi6TVAgE1MsBybcnPNUERAvDlhvPJzQeRKrX1ghPmmcavQITFV4SoIEPB1qRNlq0UCVq/92TFwQFq95kdnOHwR7BCoh8Q7Ip+VpEQGawtjVWnIRhicCItx7XcDYvin28fBR+1Cs72xUmuQ5fI3xDqHrI6ohkJayPRqHgyOvJi0Alo+eszGv66WK/MAisMMfaoQYI0tdsL3t/vyL3IL0l/zyzKwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789625750; c=relaxed/relaxed;
	bh=+K4jEI7K5jG3d7ElsjaI4ZZGrcnnZ/RJPFxiwdiWFHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4VSsgimCvAR0klZ8HVny0rR6b3OhFTkaRVurlOdo3uIwHs2adSVnKiWjs6dP5dN7iN5n9AZCic8OGvcSisP4iAq0HPillqXYZqLbOAp/7uLNWwOgNGrwbJk2m2lUkddVvVFHajvu9vJnxChZa0ntnpxjKqvHjkOHe/a293i9P//vBj41Id6EOhrjroWKCO4J5PmvTw7vwTmKlLMTJNl1G7sasB5Cclw5YLJm2Ki/4+voV7TP9JqpiKnHeqiN2C31Eqogzc7o3Pfz/5yb/FuZGLii4zVI5EfSJcOQqaUGP2TVm+U2VNEwSypO17AsAHKrquxq+4WooPknc0XeQMRAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PwZcGPLh; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PwZcGPLh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hllqn3vdFz2xyk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 17 Sep 2026 16:15:48 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so2923455e9.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 23:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789625744; x=1790230544; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+K4jEI7K5jG3d7ElsjaI4ZZGrcnnZ/RJPFxiwdiWFHw=;
        b=PwZcGPLhf1DeLvDy2fmei1iOjz2QwaKYL9YM9qldqiZ6Z7YJFu1vcEwA69CmG2HfzX
         y0Hhnu0P62ZnSTP3wZOaCIhkPSTzw9k2Z7jxbOR4DXu8ovv0W7KRZ4tFY8y1N94sLgk5
         wtuT1NQ+FMu2jvyJ9bxrRsoyl6FagNV3BnlWMJiVvYkv+wsscJeJRghadb3dUmoOPhD9
         0oMotCj2dtQsw6vv0pvSDbf13lgSEUZR8uu+Xlbu4DjXA04UjjeBNYiCzxejQLkfsJCe
         H19oJejPfHaFnW2DhMlaBQsiA+Do0+D16FzkD0oOO5QOl6qUCit95u90YYUvvmz806kV
         qPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789625744; x=1790230544;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+K4jEI7K5jG3d7ElsjaI4ZZGrcnnZ/RJPFxiwdiWFHw=;
        b=FYt7AzzU7Ct5iduwLqxoX5jVSR/SWKOlJCJ8A34Pjj+4Af6Uog13iswCJumpGYS8up
         tx9uaydijBCp6CxjGGsJNiYgNM5ylaXhOieOYRpGcnzpMto0JRdCFcKw2e9StvvSymBO
         Lm/LRCF01r4HSXaYNYdQAxbKgJS0pzzT1NiQ3D2ZwRQoa4pC8ErEE1+rySicabIbskvn
         lbKRiO089WWfCMgWK9B/D5SAzvrlKTsGAZtzaBG5tihURgeYcknipKnqO3AG8Qjzxvnw
         8pCyy6lQNR5j00M5MDZKbGJ7D0p+J1HBT92D80KpwyhR4OaGlNWLgIQIcPEI3IRysDVj
         p9Sg==
X-Forwarded-Encrypted: i=1; AKwUvBwW4C6cyiSaVSD/1kk+nrYq9jAT2uRNhXxSoxmIVp6x8YMZnfgMxYsYWwVa9It/dwyHc5Pu1EsMvfbuksM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lVBx6r4TCbmY55rT6NxnZP8btF5PfK+YQBCxxraY2U+O8BsBSh
	xSeV8/1JNZfh+kqGKy/dtE7PGvShbivL2UyQD2K7crojih82b4eOvpat
X-Gm-Gg: AYBFou3YMugGV/qwIFsS5J5kmnD3jVjd8HopeA0dVxxJ527x3ySr3SHfbp5/bKyLvBG
	4+n+GDrBj59NXo1EajinXSe7ygRsHrbibk/zfXkpkc6T5SjEY+bAQpvC+XUC1ytNSOqt89bIQHK
	cw3szg2EUMm8Y0myV+5Kp61MNAiU33BNskWjbeo1aT/KfAvXE5bZUot6jPDjjgCs3u4Cf8jcm4i
	+LmWiMlb0Syg9jsv2UoVQPWaD0NZ8yE1T2ByKdXT53K2g5BTTF3Thvdw6LF5uQpWZr7rbBQzJL7
	SmizmR+hJ6G8HeBWF/7LqLwVtme6rJL/PWji7oh06T9mKlkJJd1v0asAU+VjY5PdLZQbqPqvUA8
	fWlzAyQDFgVLLLC1aa7ZdCCXUWA6sfo5QZxUxGKDNpU+AwEkOw6DzYl11OH7y3oxmwQKUzS8rq3
	jKeuqeh11wzLZTmA/MAYOmUiMYLKPZNVWWkVx8OqX6t2QsQaduFwbw3ShlvL+3wWYxW/mPXmIo+
	A6f5zz6TPorZW6K3UQcaWU3re7TkJSXeRG5SyxoV7GjqRt3gKphFNUxDo5hHAmOL/sC1tdhD+dY
	jBK1TxfbluQHoam7FhQ3RgKMJQA2yXBIEdthnjdJGKRWO3nSHwxwVrzGq2U+xQJRKN1Fn64dGEc
	w
X-Received: by 2002:a05:600c:6296:b0:49e:602a:b4ec with SMTP id 5b1f17b1804b1-49eb730e225mr109105555e9.8.1789625743878;
        Wed, 16 Sep 2026 23:15:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9dc6-c001-54ee-4741-4927-0a28.310.pool.telefonica.de. [2a02:3100:9dc6:c001:54ee:4741:4927:a28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23f4e6sm55558105e9.8.2026.09.16.23.15.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 23:15:43 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Brian Masney <bmasney+clk@redhat.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-clk@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jerome Brunet <jbrunet+clk@baylibre.com>
Subject: Re: [PATCH] clk: aspeed: ast2700: select AUXILIARY_BUS
Date: Thu, 17 Sep 2026 08:15:39 +0200
Message-Id: <20260917061539.51943-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260712160301.98941-1-kmehltretter@gmail.com>
References: <20260712160301.98941-1-kmehltretter@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 12 Jul 2026 18:03:01 +0200, I wrote:
> Select AUXILIARY_BUS directly, as other clock drivers that create
> auxiliary devices do, so it builds regardless of the reset driver.

Friendly ping on this patch. It already has two Reviewed-by tags.

Adding the new clk co-maintainer addresses to Cc. Is anything else
needed from my side before this can be picked up?

Thanks,
Karl

