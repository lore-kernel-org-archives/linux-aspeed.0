Return-Path: <linux-aspeed+bounces-1938-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4573CC87FDA
	for <linux-aspeed@archiver.kernel.org>; Sun, 10 Aug 2025 23:31:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c0Ytw56Ynz3ccv;
	Mon, 11 Aug 2025 09:31:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754864531;
	cv=none; b=U2KEyRN7FSnI+lkDsp3I81dzyo5mXCMzdxZ4OXN1I0lWwQJHsV1Mcoi3UfQy3Ihx1g7CeIM3rYBKX+811oUAgO2EB3GmPaq+aJtmXtgkGP2QdSs4mwCjmKT9OuAz4rW5z26usT+ctleJWQrypDMVn3uQkaaI3qmwB8DcAVQOcq60A/Xp3aAvqCefOHin3HMgQ+ueG8tSzFZCDD4T84AW39pDBw1sF8hD8LW8IiPHUAMs6GUXli5RE7ZVww8urbuJzndTNKEBq/P/was43X1sAhyftUqTUuf/Pcpmy+uVAwv4PMXE30OEkdXv6tqN1nLVtxY10XGOcRNmRcJ5fY8CAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754864531; c=relaxed/relaxed;
	bh=DTxIrdPV4iWneFJR6EUg7IhXT4i8rDJLDvWWCgyO0NI=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=T1ie/hchb/dqeS5ll58NaA7xlnMVE/vYW/tVSJA7YzRYQrkD1Rl0oStK9MxpsL9wU+44wdcOHwsL8/zXYgXPafeyDbCvnysAC+gxhaQC9EAG3u/Zr8r8OACjzcRkfMo+OXEsj88U1wFkVFwrRVdNoFKuTswCSdYBnuS++D/yOFOOCs5s6/TmsuScJwlxl1pWDTG8Kcqj4oVMPiyOKM8TGubaKWajgrcSM9edeZOqKUFY+C7/9Z5TEkfspRR8I2XxkBwm2Z4Pr8hlXkgKVQIFn9PUfAGJK3A0wxUFt0eVAwG3YYb17kxBb3vIXMHqzDupvz+KF4gGLxv26uuLEvrx7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKSwrXw2; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKSwrXw2; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKSwrXw2;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKSwrXw2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c0XLp20KHz2yD5
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Aug 2025 08:22:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754864524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DTxIrdPV4iWneFJR6EUg7IhXT4i8rDJLDvWWCgyO0NI=;
	b=WKSwrXw2yhHBMIouI6qOeWCkVgGxMf7vEB6I8ABl4pMikXp8NcUzx4QS3x2n6+UCZBy7mx
	sY+nWYaFQfKSF0x//lAXqUQH5d4JeM3acESKeQje2PflehftExY4X0td8mx3bKsQpLP6c7
	3FiHSdHfcYXdfU8g+JGzKcNfgzcGPIU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754864524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DTxIrdPV4iWneFJR6EUg7IhXT4i8rDJLDvWWCgyO0NI=;
	b=WKSwrXw2yhHBMIouI6qOeWCkVgGxMf7vEB6I8ABl4pMikXp8NcUzx4QS3x2n6+UCZBy7mx
	sY+nWYaFQfKSF0x//lAXqUQH5d4JeM3acESKeQje2PflehftExY4X0td8mx3bKsQpLP6c7
	3FiHSdHfcYXdfU8g+JGzKcNfgzcGPIU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-AjlUHjtaOm-rj8bJc9BGUg-1; Sun, 10 Aug 2025 18:22:03 -0400
X-MC-Unique: AjlUHjtaOm-rj8bJc9BGUg-1
X-Mimecast-MFC-AGG-ID: AjlUHjtaOm-rj8bJc9BGUg_1754864522
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b06d08d61bso117835101cf.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 10 Aug 2025 15:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754864522; x=1755469322;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTxIrdPV4iWneFJR6EUg7IhXT4i8rDJLDvWWCgyO0NI=;
        b=X8ghZkZ8wEbiJWTIDx5T1jYOxhiEyCAzpI0kWSVwO/U9LrcAi31mpICzQRh2+66pZL
         K+Z/uCwShd8QA8u1+uKtj2xLnbwp9IxS05tGzl2bvKZOuscYlIc/pONaqv7c4Qk3DwNk
         CO6Y2VVaH/dlqFUmzRw7LMlljDjZJnxMOW2EqJgfHwsC0Sg2MlaDxioN1vc7kmlrm9tX
         of899c45IfxD+xt091FAZYGHIyp5sc9pENs2BwYdvBX2LLAlNV1c4L7D2gT0KncGc+wn
         IzsoBh1CbCyKmZZYDoy1fe7LK3+3hZis1s2RGQ6nI6rvj5DfQmD84S9ukK/KYkaTTKT6
         v3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUKydFJnsmNWxxFhmiKqCZHsNZPIQSwC31fvDcSwPRVDTajCGSN4D6UMwFgkZ9vtomqsyaeR8uzm8t6vLQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyaIaBgZqJx8kEQssK5B7J7WAO1L0tTphNvLZU9LeIV6PFuyKmp
	Wt4Mq4QI0lDtpmQ8BctKyn8H+GOv43c3E++tfPoTX4+WdE7DNnGiJew3/qXpdXeKcvdSHrrabOu
	WivQ7AXt0OrpYghxHUTL3I0gqVxBVbNH4SNmb+gMjBSxq05xDMyrctC9Su1UccTOJ6nY=
X-Gm-Gg: ASbGncvR7VuC1UggaFTYNabxiu2ZruL2Q8ipHtatNnj/7w3RrD2DWE7S3ANNirfxuPk
	eCDtrn4R2jkucf0FCgYeStNXC7RZDzaN/FU9sqt2ITtO9uAtGmbOCXzWCxuXLaFo5WPT+EN4zCU
	GOB/wcoBvnmcB/8QTSX/KFKERwmm4p6G6zg9dTvwm94oFU/BoswXXggSwsCy5oF4JPJ1zVV2zLU
	KIugeVV2CHgeHWfZwDtdSqlyf/DHoKHXEyjToLeFcG7uQIqTu8FTPXUZkNoI2UVtfqhjhpSgtfk
	pjqfu1H9tjnOnfhAMxnqc/2W64yszC4Yduhg55U3GlAFHI3lTWe0NyFJmOudC/UQ41KX3Y5Zq+4
	86Q3EaQ==
X-Received: by 2002:ac8:5d0f:0:b0:4b0:8092:9912 with SMTP id d75a77b69052e-4b0aed42512mr175423881cf.19.1754864522407;
        Sun, 10 Aug 2025 15:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0/+zhF0BEbIolaJOCDjorPdn+0fQDWtw+ZQnbIpL+/rhtw0D1XSan+ygZuYsN1eYwat9u9w==
X-Received: by 2002:ac8:5d0f:0:b0:4b0:8092:9912 with SMTP id d75a77b69052e-4b0aed42512mr175423681cf.19.1754864521987;
        Sun, 10 Aug 2025 15:22:01 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e816a9a3cdsm714913185a.23.2025.08.10.15.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:22:01 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:21:51 -0400
Subject: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
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
Message-Id: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
X-B4-Tracking: v=1; b=H4sIAH4bmWgC/x3MQQqAIBBA0avErBsorcSuEi1Ep5qNxVgRhHdPW
 r7F/y8kEqYEY/WC0M2J91jQ1hX4zcWVkEMxqEb1jVEWD/KMsl8xoLiTsO/0oK2yhvwApTqEFn7
 +4zTn/AGKlAVXYQAAAA==
X-Change-ID: 20250729-peci-round-rate-543639297ec6
To: Iwona Winiarska <iwona.winiarska@intel.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754864519; l=5809;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=L6jvK6ACaYL1SKlK5QC34DBWw1qmKVlL/yCAWgBC/h0=;
 b=ExfjZ3UpYQJq/TbnRfU0VlhnPXC/BUUDuaJmbmTAojaDwiZAdey0YvI5/J2A7xXNMUS9wkF5N
 vb2GIQ8yHxiAnFyZY8qfOjL4oDD/6ms/NRhowThZjXsoS9w0+utR2C+
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UDtD9e9U8V5p59Lv3ogvOniZYemfZg0-mDfBYx7mI50_1754864522
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
appended to the "under-the-cut" portion of the patch.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Coccinelle semantic patch is below. It's large and I don't want to
pollute the kernel changelog with the same code hundreds of times,
so that's why it's included under the cut. For subsystems with more
than one patch, I've included it on the cover letter.

    virtual patch

    // Look up the current name of the round_rate function
    @ has_round_rate @
    identifier round_rate_name =~ ".*_round_rate";
    identifier hw_param, rate_param, parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    	...
    }

    // Rename the route_rate function name to determine_rate()
    @ script:python generate_name depends on has_round_rate @
    round_rate_name << has_round_rate.round_rate_name;
    new_name;
    @@

    coccinelle.new_name = round_rate_name.replace("_round_rate", "_determine_rate")

    // Change rate to req->rate; also change occurrences of 'return XXX'.
    @ chg_rate depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    identifier ERR =~ "E.*";
    expression E;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    (
    -return -ERR;
    +return -ERR;
    |
    - return rate_param;
    + return 0;
    |
    - return E;
    + req->rate = E;
    +
    + return 0;
    |
    - rate_param
    + req->rate
    )
    ...>
    }

    // Coccinelle only transforms the first occurrence of the rate parameter
    // Run a second time. FIXME: Is there a better way to do this?
    @ chg_rate2 depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    - rate_param
    + req->rate
    ...>
    }

    // Change parent_rate to req->best_parent_rate
    @ chg_parent_rate depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    (
    - *parent_rate_param
    + req->best_parent_rate
    |
    - parent_rate_param
    + &req->best_parent_rate
    )
    ...>
    }

    // Convert the function definition from round_rate() to determine_rate()
    @ func_definition depends on chg_rate @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    identifier generate_name.new_name;
    @@

    - long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
    -               unsigned long *parent_rate_param)
    + int new_name(struct clk_hw *hw, struct clk_rate_request *req)
    {
        ...
    }

    // Update the ops from round_rate() to determine_rate()
    @ ops depends on func_definition @
    identifier has_round_rate.round_rate_name;
    identifier generate_name.new_name;
    @@

    {
        ...,
    -   .round_rate = round_rate_name,
    +   .determine_rate = new_name,
        ...,
    }

Note that I used coccinelle 1.2 instead of 1.3 since the newer version
adds unnecessary braces as described in this post.
https://lore.kernel.org/cocci/67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com/
---
 drivers/peci/controller/peci-aspeed.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
index ad3a7d71ed4c61e6123dcbbad264812cb83cbb07..a0c99ecf7f3805a1cdac55a8d5db9c61ad3cf37c 100644
--- a/drivers/peci/controller/peci-aspeed.c
+++ b/drivers/peci/controller/peci-aspeed.c
@@ -362,12 +362,14 @@ static int clk_aspeed_peci_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static long clk_aspeed_peci_round_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long *prate)
+static int clk_aspeed_peci_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
-	int div = clk_aspeed_peci_get_div(rate, prate);
+	int div = clk_aspeed_peci_get_div(req->rate, &req->best_parent_rate);
 
-	return DIV_ROUND_UP_ULL(*prate, div);
+	req->rate = DIV_ROUND_UP_ULL(req->best_parent_rate, div);
+
+	return 0;
 }
 
 static unsigned long clk_aspeed_peci_recalc_rate(struct clk_hw *hw, unsigned long prate)
@@ -394,7 +396,7 @@ static unsigned long clk_aspeed_peci_recalc_rate(struct clk_hw *hw, unsigned lon
 
 static const struct clk_ops clk_aspeed_peci_ops = {
 	.set_rate = clk_aspeed_peci_set_rate,
-	.round_rate = clk_aspeed_peci_round_rate,
+	.determine_rate = clk_aspeed_peci_determine_rate,
 	.recalc_rate = clk_aspeed_peci_recalc_rate,
 };
 

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250729-peci-round-rate-543639297ec6

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


