Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E23606A326
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 02:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kkNW57Qd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLNRT2QKMz2xHG;
	Fri, 06 Nov 2026 13:29:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793932165;
	cv=none; b=dDRrW8ghjmndWT9a60hdPjsWR5xh3OLvm1YwsDJWUCHzqdvPD+ubpOvfG0PiSp36rqZSiMylnYs2BDpJDL07HNBG4mmWmOnfPedGtzvO/4kP7oZyaAHoMHFuuXvMB/j8PhuU7LpdiuE7s2yWeYIsRTKyOp+SK+HvWGOY4ewJaMp+se6b/CYfA9oE7/DSORVTmCAMkkb0jFTxstCJA3nCjgmx74Pe31Li9tBayjZeGdY07Dl/bqZqbEDlGUJSEOQBFG3yw/1yKjK3C+G9skArwSMkB4X8tX2HCLi7FEa8qkVsjPqV0m4R39naZDaJorQAy0aIRONq4QaZ99ObgwqayA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793932165; c=relaxed/relaxed;
	bh=O7t6qfqKXOFT9HGLkohs0lc0zBkf/KGLioAvYKS1zgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOiuSF32P7XT2u66fNVa13qdiUULju/Z+k52fWbWgMbCikEU82PbjbiTm5sg3s6Yjog/PdNdwVccgNKIcurQzjwIHftpOT5lvJmAatijN4kCsZ8FBK3CAz4r1psHZPxCCK0V0f4MYbRp1Tu0DLU/VDp//aWc8auTEfcePiyDAOijjwtFwEyr+8GayXPfQBYVUkBpPoYaNNd6k8roI/XgBvFiOJ6wXOpM+qC8jgVKhgmgRAxRlPoDsuOYDInywnqDPpDVeIOojEeVWnGyccFQKWGBrSF0OlTQJjjCtdBziVhlJkdiOEXVDmJT1uJMwb/8rmcRPIk4k0gdrplY73TjmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kkNW57Qd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kkNW57Qd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLNRS4sZvz2xJR
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 13:29:24 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so284833eec.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 18:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793932162; x=1794536962; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O7t6qfqKXOFT9HGLkohs0lc0zBkf/KGLioAvYKS1zgk=;
        b=kkNW57Qdb/V5P0NbTKIl0aFBC4WnSVJadsGMxhagNWomGqzuarm9gNuSrmrZhsIQ4K
         JIvvSxzilzqe65rQMFhS6Gc4+/vaIv2OfvyCHuTr8bRVAKtkMG9h/VDPRT9i8nIg8d71
         sT3uvTLD7a0DKuhTEIaKG5qeW/vPPPECSzybODgwDXD0a9ypRTmOuIAAHVhdIGtACTMg
         +3OYf47A9Tl90bmPZgw1a9jD1nEPUP6PH2WvexJZoocsgJmStvSChmcclXKxYIr1bDZR
         Du5RaDRQWMVxbwgFujssmUa8ulxHB3IFgKDb4pWLbijYzAjT/Gpldj3Hwht/utrcJXRs
         VByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793932162; x=1794536962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O7t6qfqKXOFT9HGLkohs0lc0zBkf/KGLioAvYKS1zgk=;
        b=uPFC0pI9NUFREzOarZilKM99odIfIyEDGQF2jlzoZjTUf9k19yIOncaJgRW7JDfvDM
         rv7LJai5oaJ6slstBcXMZEnN33l1sRATEXZn2z/cqD9odTQxUpL7dYV6sUm+v8Bl4+n7
         b70s6qt0N7oNMPNLdKtC4FBtdne3Y1jDPMsTd1dTRYhaaznbEEieI2UbMRMt0B9fWT3J
         D7je25D2eAfhebSJeFyP+5fhbdhac1eD15TJ+puQcb+yjEUELL2sE7kAh9tDYnUZQ3eD
         wOqgqYQgphWqsETgx63UgvVwGahwydK0usNCgp33HNKu4oM2dURwtNjkFz551IkReswA
         46SQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0n2AM2Qw6Rn7tu50mdBk2quoyExsg8u6ynA9JbaxGtImEf4la0SAKb6ldlP07XYCeHnM3ynPUtI3UBz0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9rAolaiB8v5twmFQSv4MGuzACVK/XXQByfv/awyW4tXIxPtw89
	zGhD1w2n4NW6XiiaTdGkNx/js/xD8B01GdemVX7WpSHvk89yszqFcKZ8
X-Gm-Gg: AYBFou1GFqSGMcKGiWH/f/wd4X96YoVIAmRtuWXi1FNfe0/PbnPEnciNS5NGwee5HzG
	7qbPH1vZ5zlXRufm6zAyY0OYm//YSgqipP44/16EHagXzozwapZ/i6zOBWUWUxiwa2xJYXW5BwM
	dcaO30PngxisiMXTwMcf5f+aM7suL95OX2A0d9UDfIeeDi0pLrxlXSAm5G+7E23ix516BuAdNq1
	AvOcQCvRPD3eqkDgujrfy/kWwzS5DMCx449Xo10HQpgLLIUvDuNrSIooisPrNGiJCF+YYhrz0AS
	PcZXoTgOPDFLW/Dzf2DKx0XN/sCAEBmqP9JgRYsig8YP7lZHxxeauR5dITaZblSoOhc5gSwDvPi
	0C7uuauh+N35aLwizKw8jvigNt6nZWd9Lb345sX2zFXM0OpbOdXw9+vlbhjPFILHkV1Hw3YyIPp
	d1klY8FNHITxAjOAdJ9CVEmbKsz8uGAQGnDuSDj49Db1S6y/OqT1H9455pr95wTsVwH0vyWnU2r
	L1YfvAwuIyrplaD4o4OCSbKqMj7mZ4hMM31SgHK4o3WaYYzySFLJsY8ErtKc74qrbb6BlriaGRa
	TaMwNB5OMy1PMxYUto/Zxvz3dvTWNmJqkLpvm9+hMHy0e9o=
X-Received: by 2002:a05:7301:fc02:b0:36a:1788:3d1c with SMTP id 5a478bee46e88-36f761249e4mr1506830eec.34.1793932162278;
        Thu, 05 Nov 2026 18:29:22 -0800 (PST)
Received: from debian.prasanth ([103.183.205.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a47esm1700358eec.6.2026.11.05.18.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 18:29:22 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: linusw@kernel.org
Cc: andrew@codeconstruct.com.au,
	joel@jms.id.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	brgl@kernel.org,
	tan.siewert@9elements.com,
	linux-aspeed@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v4 1/2] pinctrl: aspeed: Use managed pinctrl registration
Date: Fri,  6 Nov 2026 07:59:06 +0530
Message-ID: <20261106022907.10735-2-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106022907.10735-1-prasanth.padarthi10@gmail.com>
References: <20261105152348.8567-1-prasanth.padarthi10@gmail.com>
 <20261106022907.10735-1-prasanth.padarthi10@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The shared Aspeed probe helper registers its controller with
pinctrl_register(), but does not unregister it when the device is
unbound. Registration can therefore outlive device-managed callback
data, leaving a registered controller with pointers to freed memory.
The G6 handover change in this series embeds that data in a
device-managed allocation.

Use devm_pinctrl_register() so controller teardown runs before earlier
devres allocations are released. This also cleans up the registration
if later probe processing fails.

With this change and the G6 handover patch, one unbind/rebind cycle
passed under generic KASAN in AST2600 QEMU and on B650D4U hardware.
Controller debugfs entries disappeared on unbind and returned on
rebind; a subsequent pins read succeeded without observed KASAN
reports. The unfixed control case has not been runtime-tested.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index 7e0ebf11a..d19b4d23c 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -461,7 +461,8 @@ int aspeed_pinctrl_probe(struct platform_device *pdev,
 
 	pdata->pinmux.maps[ASPEED_IP_SCU] = pdata->scu;
 
-	pctl = pinctrl_register(pdesc, &pdev->dev, pdata);
+	/* Unregister before earlier devres allocations such as pdata are freed. */
+	pctl = devm_pinctrl_register(&pdev->dev, pdesc, pdata);
 
 	if (IS_ERR(pctl)) {
 		dev_err(&pdev->dev, "Failed to register pinctrl\n");
-- 
2.47.3


