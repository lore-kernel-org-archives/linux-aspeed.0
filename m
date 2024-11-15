Return-Path: <linux-aspeed+bounces-128-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6AED6DDD1
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Nov 2024 04:43:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XqPY618LCz2x9N;
	Fri, 15 Nov 2024 15:43:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1149"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731645818;
	cv=none; b=ethDZZhX3TzHWh+kAxyCGbJutzj2ucgclD79AzYuSFYEgnArX2tMjLcoV5GoEaInGmYgoyJPo5le8NuD9EPZLFz2RH39NGhvS8bv57W3WpsZYp+RuhhjT9KAliEQlplbN0lhFINRMAIZiElex4dw4uyRwLLEbzd3Mqu8TEZYaB9ndZUMl+ljzRFs1Oh62NXPMiHYaYXp8pwV+H8yb3ZuOs7NFOcBOHkWc+XvPWpnO7fZCqp6XR7kNvY3sxSZseyqctmM02OyByNIqylDtfSf3DQnDbWWW2JiM/RBrYSzpK64uXGGtOEh5G13IctwYq+iqSpnX8dAJnJ8gTuZ75SJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731645818; c=relaxed/relaxed;
	bh=SWTmFeTgm2VLDhjQCMJox51wxvKAPwETC9oW5QsHWQ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n5wJbeNcazGpbXATDC/dUwkHOfCZgJk0KHJ6wNToV5z6i3G8GcUMrbkOqO4Cxq30nq8KP0/bnC8zOiI36CtAQevzYNFeswHEM2A1slGCEMsnEkP/5sEFRifuJK14QiemE2My2sPUzDGPYINUH2qVO9JDa/XkD0Pa8x15nz3ar20ECQ3L1RDd/DOHTjCDSuEFYT1UDm22PCx9BHkz4OCFYEnH7WuieIW2zCaUu+jZHyO3VN32dKmjl7RfZOOaIWWTLYOR/0SOo9lxZ6UOCPy853EEQ0spcjBjhqGuARXFq1RON46yEaJoO3N0zlkjcoIlm1D50AvZWxxPG2vZakC0+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=b019XWdP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=3cte2zw4kadeoeraqnauvttvaftbbtyr.pbz@flex--brendanhiggins.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--brendanhiggins.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=b019XWdP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--brendanhiggins.bounces.google.com (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=3cte2zw4kadeoeraqnauvttvaftbbtyr.pbz@flex--brendanhiggins.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XqPY36gGZz2xFr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 15 Nov 2024 15:43:34 +1100 (AEDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-6ea8a5e862eso17078807b3.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 14 Nov 2024 20:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731645810; x=1732250610; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SWTmFeTgm2VLDhjQCMJox51wxvKAPwETC9oW5QsHWQ8=;
        b=b019XWdPFar1k8dpVDUt+8OT6hBJIXpSx+y6t8Z1WijNE8KDFxfjPTIUXK5Y/jE7Ne
         2ABLQiGbSLNUQbQLlyQC35f3LWowFsvQSlUppr0cZw2NFTOVlPuPw7nWdnWZEkAtxPOM
         9LOR13VOe8syXQnTNTXi86s+5gTpAe+3tO5LZw1jbMDPpaqbTBxVSbdD8wkVWN+BHPKY
         LVT70YqRydsHj69vPknKd+KyJyJsv5NY2rhorYuGvIGrWCEUICeCpipg0w1RwhGaZ/gd
         9xRNZxCk+RmfigO9/bn73wIvEsIB5XsMmnRb13u19ycYaKPh0ydv3PYvJoMy01M/7pl0
         yMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731645810; x=1732250610;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWTmFeTgm2VLDhjQCMJox51wxvKAPwETC9oW5QsHWQ8=;
        b=V/34f93heYocRx2JdTFrFNstClzg0t9T34mC+/dwN91BtZ6S92CrDtydrD+12lmqq3
         7dEDTTUihRr32+W6K3CvjLB7jBjoAb62D15OjU+FRJSMEJhtbFLbZH3LyVV2kazXiraU
         gKAtaCYwCfjQRdCjP2WaqQ8qPLwTveSjoh6imnNXviEfcbiqtVzMi27JpiJ2Lg80YukI
         wGZXrL0EKyCVBquatgFTPH4/oRWvQIJUO6keBd2fo44MRNtuwXXHolYOb6QGAWB4FoK+
         4yYm32QSq7/KXLO3SepfPLqy2gSC6p0JXcvlE4JZyKe7X48+cH8PEak+1sOvVDbmXWy9
         lFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpLdFqxAk0m3pV0JQdzTs9DyyIN0G11tqR8zXSXRx1RtW7+B141+Mn4c5DW3QZpBE7WlsParRPcC9KSlA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzTCtWzrojWt+kqvxqmRCbANR0zquvs2NZOKokA7wElQTYSqzll
	FM67HD9qCGR5qSkyoUiHvYzljwy1/9ekDDY9AmP50YK0EFikRbY+IHetaYsVWPO3Dm06fk6mJdm
	shHqJ6dUTiSagO9e6TVME5YOyp7XoKED4yA==
X-Google-Smtp-Source: AGHT+IEJ4NE2/XuDDDNAEKvda+FMnKUt6iMnc1swX3o47JMptB20Xn++7Qkq+lJu0qkPYYpm82OXCWt2SDYG5Lf2Rsq/yA==
X-Received: from brendan-cloud.c.googlers.com ([fda3:e722:ac3:cc00:141:be02:ac12:7acb])
 (user=brendanhiggins job=sendgmr) by 2002:a05:690c:fca:b0:6ec:b10d:5745 with
 SMTP id 00721157ae682-6ee55017265mr1428467b3.3.1731645810171; Thu, 14 Nov
 2024 20:43:30 -0800 (PST)
Date: Fri, 15 Nov 2024 04:43:03 +0000
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
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115044303.50877-1-brendanhiggins@google.com>
Subject: [RFC v1] MAINTAINERS: transfer i2c-aspeed maintainership from Brendan
 to Ryan
From: Brendan Higgins <brendanhiggins@google.com>
To: tommy_huang@aspeedtech.com, benh@kernel.crashing.org, joel@jms.id.au, 
	andi.shyti@kernel.org, andrew@codeconstruct.com.au, wsa@kernel.org, 
	ryan_chen@aspeedtech.com
Cc: linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	BMC-SW@aspeedtech.com, brendan.higgins@linux.dev, 
	Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove Brendan Higgins <brendanhiggins@google.com> from i2c-aspeed entry
and replace with Ryan Chen <ryan_chen@aspeedtech.com>.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
I am leaving Google and am going through and cleaning up my @google.com
address in the relevant places. I was just going to remove myself from
the ASPEED I2C DRIVER since I haven't been paying attention to it, but
then I saw Ryan is adding a file for the I2C functions on 2600, which
made my think: Should I replace myself with Ryan as the maintainer?

I see that I am the only person actually listed as the maintainer at the
moment, and I don't want to leave this in an unmaintained state. What
does everyone think? Are we cool with Ryan as the new maintainer?
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b878ddc99f94e..e7fba34947f5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2195,7 +2195,7 @@ F:	drivers/mmc/host/usdhi6rol0.c
 F:	drivers/pinctrl/pinctrl-artpec*
 
 ARM/ASPEED I2C DRIVER
-M:	Brendan Higgins <brendanhiggins@google.com>
+M:	Ryan Chen <ryan_chen@aspeedtech.com>
 R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
 R:	Joel Stanley <joel@jms.id.au>
 L:	linux-i2c@vger.kernel.org

base-commit: cfaaa7d010d1fc58f9717fcc8591201e741d2d49
-- 
2.47.0.338.g60cca15819-goog


