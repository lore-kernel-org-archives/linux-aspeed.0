Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72089606A330
	for <linux-aspeed@archiver.kernel.org>; Sat, 14 Nov 2026 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iWeCWTmL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRRXb01dVz2xL1;
	Sat, 14 Nov 2026 19:06:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b135" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794643582;
	cv=pass; b=hR1xx2YGOV/UL5So+D+oVQq41B0cuZV3RQDXuRD2wCHBsgYj9phrO+yBaibyr/Xbl6JqzQ/XJee3237//3p2/ZVv8Vcecd5jgZRVUT6SzjepIbgJ6pkZxMnwPyAUTGK1DWBel7EiAsXQwksAAfYVQwAjmxdz5MxQAU89LSio+8mT62F+kDntr8p8OBsFQl2fJz10V6/L4MOScxoK7X1GQNluw4ncMU2ytiVsHD3N41jSlatUnRjNfXrHNPU/bNFY6RZlJq649BVIJV+c5oUl3LlDgopC4KgnyKxZMdE+RcDmnRKBjTfbM+gyZiIZ6nqA3Ydd3i4HBLvLP4/jrJ5XIg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794643582; c=relaxed/relaxed;
	bh=CThkzk+wO72wcMoqlLIhQ28KYAcKgLElI77Ua6aR7u8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EDUvpbulaRihccfsefXUtftL3zip3kjMOK600mBiMojJOcI6QKmVekhbsfsk3UME7MFfvY0cT4w8qszrFt2Zj99X45hXffPYSuo+GKSNBiiAq+b9FBUkBnB01X0K/tw30FN3hnvJlv20fAM4fdTzzMWv8WHn4DgHo9qKSVBFyL3yClZ2fsQvmq1UYFTFP13iTX5RaaquZH/92noAc2UJT5zjkjIf8dktfWnU7oBEyJrH8bfGaHxavpcwBCs6mnv9N8VQeHNHr9+6XHtfYy0wEkZFJrw7r4fZcK0mv5kwy2WHXPe7zP9mlaVL2EIB5++1ceX1Uz8WXnUDEBx30Y2w1g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iWeCWTmL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iWeCWTmL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com [IPv6:2607:f8b0:4864:20::b135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRRXY2Sb6z2x9N
	for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Nov 2026 19:06:20 +1100 (AEDT)
Received: by mail-yx1-xb135.google.com with SMTP id 956f58d0204a3-67c2c2ac1c3so1844599d50.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Nov 2026 00:06:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794643578; cv=none;
        d=google.com; s=arc-20260327;
        b=pKLC8wOV0NhrKFk+qDvXIWU4fHTTubOm/viE8Q3Bo/UHbSPS43HhcdLW6CNbX7Jtua
         EPAEvBrdKzp55M0444CUxf99cvARivEh3Hq8Zg6+H5wCBhgguK7YdcZi6IPMQODerrMz
         O3d+HYdwV3Kx370PLidVOc2ohEQym+afDHzSOuAcr8MjLB7aoigDD79OyqmIFnfSrluT
         veCgVmTm11W4Bokt6yRWIll1o4gGQ+vAdBaiWJHZxQrMqk2qwk3hu3HDe4/1LTNfiMrF
         9yKgtFG2jysWWaJl7IPxQP9IIPQTar9KOUsaWOB2c5dRAlnLrVJ70PbIIf3hrSHRo3cV
         NeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=CThkzk+wO72wcMoqlLIhQ28KYAcKgLElI77Ua6aR7u8=;
        fh=gQttPKCuPEfMg/Y2d/jpPcMFxoJnqfYqloyUywT591Q=;
        b=X1HPKRqHbUPvTZDQPBdcXnoTZJVoYc9de6FE5bC80lhmuBV3BsB/llQo2l0/8DcVoN
         iRERkyHCXNVQtVpHQiRkGbW8PizVSnh58QTn2K+6IRUDBc7GdG69Ov/vfJIE92ZnVKX9
         sR8tTXHxNeKWvG2DBeSwTh1hHkN5R6FBTbjN4vufkbZCSwqphXwqHDrq6SUSSAAAf6iu
         B1DyCHAGKiIj73jq7TbQSa0vfE6T4rqYcOh32JHKOgvvBvO05BO9CJIbGA+oJuw4J6Tr
         zKjjd3QjHXpJSyKl+EhdY++WIv4aqJQD5Y6UOkdFGcLaea/NpGAAwFs48zrqgrRVM45b
         FzDg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794643578; x=1795248378; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CThkzk+wO72wcMoqlLIhQ28KYAcKgLElI77Ua6aR7u8=;
        b=iWeCWTmLP5FrK9YnD3m5GArVJPs4UX1L2X3Ms1Jt1HsZCLtusm2QtlXE2X4cWcrTA4
         7LooHkLMZSwCu/09pGuRO3RoDoBGKV8yGzkKqJnA0qr06CQkxoSvraCBYJJI2q26n8Mx
         YS51PWV1OC0LDWikQaxBu466D0v3U9fYtfIFy1DR4uy+5I5KHdJit018OWmm7Kc0OaXD
         nG+ZU9ytj/PMV1Ly0YJEbYTkbSK1th0eZOs12S4OeKn+bciVQvYvwGsoJq8AlkmQUlpH
         76VbsDfjrII4pQydXC7lkXQQSUA9WWMaYZmO4Omt+vSHA1cK+8pmvLm+1mdEymFo1YKO
         BtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794643578; x=1795248378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CThkzk+wO72wcMoqlLIhQ28KYAcKgLElI77Ua6aR7u8=;
        b=jk2SWtW2TWclUZmDNIMAEEnnXjbv0W5dRu3etFlNjkrtSrhQOfvGVuwRaAdTIhAkTU
         yIAzW1JriUGeyAurz5uvtu9o7qYPWFcLjwLW8uQdpZ6kkiqKccHZZkQiP6CHZm+JW/H2
         Hi++N6WUy03VFwtuf6PfYflCxzPBDMQUDu6xU0UsVWZtxuuwR9zDYavbUtteUed7UvrT
         x+C9OGLZ97Nn/PIYs7kEj8uQa7odr5iUJRL1HgbI0CUnacCoACKXNjapOeAy2g58E5rO
         l9IPysjo5voebZ9UpvCEcH28fJGYRW7s1B6E7/wUsfWxZRRB7OzkkxnVY30CB1Xi/MKI
         LDKg==
X-Forwarded-Encrypted: i=1; AL+hErE/YfpQuHZyySGaWApZgDUzLMfr7azUWHljDF1d+ODEnqq6cLDcVKoPMez49/dPtagcDXao8+fWra8JZSo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9DQav2aX/77n+PLkoQ27vrhutOMj+qnYEwm+XoQXofJ9BGhsxE
	hwFZHh1c8escMd7tNmbY9L9Dd8BXUGRs5GdEIe6Xl/jRqCgqk7axT4ZgaoNqqFM8LFq0/aZEkXy
	/q5YncxASPEnhWup9u/DHww4nsIdEyQ8=
X-Gm-Gg: AYBFou1A19Aw9uc205+3W70RDDRwoiF9MZhesr/R6vi5L8JQoopyrwq5rzB+ymqgvNB
	vZGaUE+p0dCwdzbQ2+SnZT1oajVUpj14DKwSDlZ26dvtvz96W40KcH9LqF/zs46Rfhl96TkPPDY
	ZG+umY7JHoSsoX4zaVzZqMn20fK1g7uNrXE8/DAGD5Kd34REx4nGmjDlBjEPuqEpvaVTm5NZvGt
	e67YW0ltnjpNn4iAvXV1FZsp4XIlmoQF79x9izoLUQ9VfGaT9gsG8/vV374/Q58gJ777xh+d//3
	94eP8UMsBNNQOKeba/aJ43H/fKQI8NHSnvhvSXZUN8XcPsGIj1MYl9ynQAauf6Mwh4allN8OTsp
	1LYsrlaX1oyClvGG1K1MnDJNYQnUD9huxsKkcrdE=
X-Received: by 2002:a05:690e:4186:b0:67c:1dca:80f with SMTP id
 956f58d0204a3-67d896310d6mr2503653d50.54.1794643577808; Sat, 14 Nov 2026
 00:06:17 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Sat, 14 Nov 2026 13:36:06 +0530
X-Gm-Features: AclHuK-1aqq2FWQV5h3GQJHdRY37aliUfH_UzivDad5y2JjEw9CV-UkBYBQ0T_E
Message-ID: <CAMFFDGivXPRLWNVY-g1ngfUXiHRCFPfn5uAOy71mtpi+J2=M9A@mail.gmail.com>
Subject: AST2600 OTP NVMEM driver: hardware clarification for v2
To: neal_liu@aspeedtech.com
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Tan Siewert <tan.siewert@9elements.com>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Neal and ASPEED maintainers,

I am addressing Tan=E2=80=99s review of the read-only AST2600 OTP NVMEM
driver. Could you clarify these points?
1. Completion polling: Why does the downstream wait_complete() require
two successful observations of SEC14[2:1]? Is there an erratum or
silicon-revision requirement?
2. Timeout recovery: After a command times out, can the next request
wait for idle and retry safely? Is reset/reinitialization required?
Can SEC00 be relocked while the command remains active?
3. Read initialization: Must software restore MR/MRA/MRB before
reading? If required, should this happen once during initialization or
before every read?
4. Timeout limit: What polling timeout is recommended for read and
mode-register commands? The current 100 ms limit is an engineering
choice, not a documented ASPEED maximum.
5. SEC54 range: Does SEC54[5:0] use 32-DW units, giving an effective
protected prefix of max(OTPCFG0[21:16], SEC54[5:0]) =C3=97 128 bytes? Are
there boundary exceptions or restrictions on changing it during Linux
operation? The driver currently rejects nonzero SEC54 ranges.
6. Programming-protected reads: Are ordinary reads supported when
SEC14[8] is set? Reads on my B650D4U passed, but the tested addresses
had programming protection clear.
A public reference or shareable guidance from the Secure Boot User
Guide would help justify these decisions.

Patch  Series:
https://lore.kernel.org/all/20261113034213.158390-1-
prasanth.padarthi10@gmail.com/
https://lore.kernel.org/all/20261113034213.158390-2-prasanth.padarthi10@gma=
il.com/

Thanks,
Prasanth Kumar Padarthi

