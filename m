Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12018606A321
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Nov 2026 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L168rH5N
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNGFY2lcCz2xwL;
	Mon, 09 Nov 2026 14:57:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794196641;
	cv=none; b=OvK08pKHEFwVQakJLI2BVNNJU+6t4f9hb6nKbNOjncOL5rJgH68+6Br5DHicnL+Jj+aFN9aWxk2mGlrzUoGPNYY6GpO0+TswgSh6dresy0mE8JI+rLvXYL7550G3RV+aJ6C1V6nuzgFWY/bI6T3cZ9ES8G4coUuK91GDJUa3baGRM/dY369Y2aGB/golQmfcOmJS3f0vxiW1ZDRVPFTYBNqKz6+EpzCQNdzNi1SedUS5fjs0og70CXHiYpOr3G2UcZwrSik7LqpF6Eu9IFUYA1VKa20/8e7IseiDu5Xnnczwoub5/oSm1nfShOSjMnPQqu9inu/U3oyY3Tc6TDq/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794196641; c=relaxed/relaxed;
	bh=zzUsqoWWp/37aI1KkAkv33nSCnrwJtj8I9U8iTKFJOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDVOLglsZbWvp7U81jGAtkgRb95BtyaVrHetxhYb8Z2VF3vhl6PE3o94Ei/bBLciKrmTlO7txIAOqBi/lNGm1TnRqrh9lDeRO9IHb1YITYMCciKekgqzxhlQbZ5I962IiBmPv/qw2KgHbTjgDlQnS+KHOGfX60985QQCP13EcKwFr91uEdDJxt3pFRiUkd7A6234/wj/42fj1d6GJO+eC2u+qr+E69jYQE3qIuy1J/hrRxj8W7ImqhFcCv3rFF2kZc5f0aZtT66n89sEoYX1cH83nnLIHEZsH37fW4BQjqvjMXsHlkTlqlnRiu3CuFQ3Knk7WjXJv+vHf9S2dTGyXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L168rH5N; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L168rH5N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNGFX27Psz2xdb
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Nov 2026 14:57:19 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so436007c88.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 08 Nov 2026 19:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794196637; x=1794801437; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zzUsqoWWp/37aI1KkAkv33nSCnrwJtj8I9U8iTKFJOg=;
        b=L168rH5NVNpc2hnejbnu7sDlvN/NLHwSmYwv4YRBONyYnQ3Ho/6c5zQ5uSmSZJfU3n
         3HkTGmfoxNCPmYqhii4gDJ2yNQh0K4bUIN/NumycecnNAavBfjDX+qE0wK453N821waq
         cyFKB6J9d4BMQaAA1gZdbkrl784lUlzi2utU9eqix5Jco9p3pi/8d6LzMVpf+DrvyHUh
         +FqarGSfaXptN7kCIjdAitiF4P4r33do4TFscrb2nLdqieZluEh/Wj4BkPb4dQT9fxAO
         +LsFxuFBdnvbluKY1EBhQRdStBoq6bdcrlnUzLMTj+YH2PwmwlXr5f/Bo9K9MNR8+Dtl
         PcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196637; x=1794801437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zzUsqoWWp/37aI1KkAkv33nSCnrwJtj8I9U8iTKFJOg=;
        b=tuGgKR53k/jEA+kxClHEmaQSzh5XiLLqRqsTweE7Mh/4nN/M1xcy3AIIkP9d66tyty
         /pOcHw3fCpkXc2ID+CBnEyVlBIvObfJLnCnAFKDsQk07J3Rx/hSq4Hbii/9FFoB6jQzD
         x6JhPacgxc9O7o6l4TdfmwWyFO/ihH/obtqESB606jJInHbauXKXcwgnhxT95qGayGRI
         7DGJ1AbbKvjptyZN53YE2CAPUOE5stccpH1Rpv0lmElLGpjZ4LbqSnqjExSHGECOx5yD
         UGT+FUz3OqBNpmYw+AmXEqIdDEDORxqOeM8GKFXBWh07l9c3YNrDWYz40zf2EuOmhTLs
         iffQ==
X-Forwarded-Encrypted: i=1; AL+hErHZDdDmj5Po4s5KG7A30YyWkDIa8zXJXI+keTkXjNVRpgdRJXWa7D0+9rcHkefZ6nYLvkpmosqnqsp439g=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z95cMRqar03jGaqZYfMoEJRAgnKuoHQwpB4ZsEo74oCxOPgxbaW
	zB4QCN6tzXq8tmJF2CYPS9OJbIyjR/ttUY5utKs1QNDz7OhGJedEeAfn
X-Gm-Gg: AYBFou2EKvzU8xU7pig8To8SyndHdjvSAQYCgj7wkbLOaDZXIta7C0dc0Mktl7OPAlv
	T8aaGE4jBuXL6CEGZAo9gcJHQEEknGW6ZXKVjVFo1ZXTbjcvPjlgMqd45JtXSk+iMgUZ/IMUowQ
	J8UtPLJztoaLUB7ptboTQgrqH4QHsDRjOY8NXSFbCMSP2fbjXBNQZf1PyZTvXUpeFY+Dav4TrD6
	JJvyPj+cHcSMWxl824x789SCPxPYgOPiIrsWXzq8xV1t9jbmlkwULQhWXB104OIUgxCKRrYELTi
	yyKCzHuqo1ci93NVSRyQxXh7d8xd8UiG9Jw+nrB83+A6M1B2wxONS5aYcFtBN/ryiGLKErQNyHh
	16HgFLGkfIvHBZ58gzCbbZvhEaT8RFKe73XljHZJ2FJM/8NYWhUVKpRuBBXXtf3oUJsfge6eYdh
	FYmwRVq7i91cbqwKPZD04kHNuEsgIPyof6QJD90aHDLyowRUWmPaCgVTVgUt7OBnk/0ZiSKdIud
	tFjpfZqmci0hEqj3FGHJoUlbnBU0NWkreijPrGK5KnL3XBbg4LuNHEp/9oUUYkUAqgl9KscbzOT
	CDabxA9kufQoduC0SJON9zLGTHCh1mCpGEytNQ208zCltQ==
X-Received: by 2002:a05:7022:1709:b0:184:992:c9ec with SMTP id a92af1059eb24-1b39fecbba5mr4108971c88.38.1794196635837;
        Sun, 08 Nov 2026 19:57:15 -0800 (PST)
Received: from debian.prasanth ([103.183.205.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37560d95dsm8720109c88.11.2026.11.08.19.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:57:15 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: andrew@codeconstruct.com.au,
	linusw@kernel.org
Cc: joel@jms.id.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v2] pinctrl: aspeed: Use managed pinctrl registration
Date: Mon,  9 Nov 2026 09:26:33 +0530
Message-ID: <20261109035633.93522-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107012236.28069-1-prasanth.padarthi10@gmail.com>
References: <20261107012236.28069-1-prasanth.padarthi10@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The shared Aspeed probe helper registers its controller with
pinctrl_register(), but does not unregister it on device unbind.
The registration can therefore outlive device-managed data.

Use devm_pinctrl_register() to ensure the controller is unregistered
during device teardown.

Fixes: 4d3d0e4272d8 ("pinctrl: Add core support for Aspeed SoCs")
Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
Changes in v2:
- Add Fixes trailer.
- Add Reviewed-by trailer from Andrew Jeffery.

 drivers/pinctrl/aspeed/pinctrl-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index 7e0ebf11af16..eb5f404af8c2 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -461,7 +461,7 @@ int aspeed_pinctrl_probe(struct platform_device *pdev,
 
 	pdata->pinmux.maps[ASPEED_IP_SCU] = pdata->scu;
 
-	pctl = pinctrl_register(pdesc, &pdev->dev, pdata);
+	pctl = devm_pinctrl_register(&pdev->dev, pdesc, pdata);
 
 	if (IS_ERR(pctl)) {
 		dev_err(&pdev->dev, "Failed to register pinctrl\n");

