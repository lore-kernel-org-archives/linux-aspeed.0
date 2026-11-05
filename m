Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF4606A31B
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imp3f0ta
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLHDv5Bz3z2xRm;
	Fri, 06 Nov 2026 09:34:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793865866;
	cv=none; b=TT+/slzYoNpA7p4jnpftI64JyKBxPJKkggS7ARsJG/ySQCYMS71nbNb8QqzcC5gwI5NRUifaHP7Vsg3Dbwr8nmHTakBvO5Bzo5Uoa0XmlqzszYG84hLxDxdtyXAw7BZyZASJoIV1E1ZaTeC2481XX0EHC2i2rnexlnN1sfaTPn7G8iR+rTS0cd/qpLZd5U7TVlbrm3DDO6qhVgoSkMTbnrhd21SFQPBHOW+kIZowfUe52ULh2TQH55NLcNgwaaa/lJXmoT1QN2OHx3lLMbbZTXvPqdF1bu/8n33rkukbKNjxUBbH/TFSiFwpOhPeFq49z+IzCjKKcVtB3PMC3LXxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793865866; c=relaxed/relaxed;
	bh=yd94sB33j+7uHnUeucF6H8CRpAAVi5CgN1RGqzbz/fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckJxfAdosnmgXPgRktt1AJkVCwey3XUGnAjPQBCjwPd3ylIRz3IorVnmE2HNjP5xfSBm2guyRp5Iaakb/M2PhRrUSPH0WOLtrBmcwuCIgi4nIEsuJ+67gzrdxbYfXynsi7wF2mCEWJqx4I2LFCp1lBjUOVzd6ofv3KXsjUdreVqm8nFd9UWudBfmiRtXdJnguERGHUtaMqLvOYBSZVYu+SnAfZL4X9Cd9n1FdbLWflYRChvfitkfK20QZEdPVK4Smg9w7M0y1hM6z/EquJMeVB7k0XZljs1MFrE6phsNQMcAcR2brVGl7C/XX/Gj1b13uqCGT6JOWyCiTZkPa22g7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imp3f0ta; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=yigejiang86@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imp3f0ta;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=yigejiang86@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKvwT0R8cz2xPB
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 19:04:24 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso846265a91.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 00:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793865862; x=1794470662; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yd94sB33j+7uHnUeucF6H8CRpAAVi5CgN1RGqzbz/fI=;
        b=imp3f0taILFCIQmOTlDrt2pAsEnxsKTObUXKgysE6tReHhAQRe2CUe0ym9QpGbl+Fr
         ZjO8kMoSStuSO2XioUYwKMoinhhSdT3f1PKOnVcT/nAQdVSFf82wWzNSGTyR4rFfHhRf
         nxvj5j2ISCiciCvFXizFmywohvQlZaZKgmrZxERgwp0VTcwN0j8aD3vOe22Q0Is9sRde
         CaD7ceiGd0zIIzoJOy4zqKz+4oJeu+yMkQiZoKIIUYd3I7l2CrUv0oUF/k+HuGpO1tKK
         0qOxkZWOUobKwsT3zTpocMXF/JO/igz9owDd4uIbkieHic4gotcHf8wqn1NKmHQMJIeP
         UR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793865862; x=1794470662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yd94sB33j+7uHnUeucF6H8CRpAAVi5CgN1RGqzbz/fI=;
        b=dpzwWNdZdTt3J6Ojo41qCQVxCm5NX0M25O9egz0FiwCD7tsNLsZTvJsBCYoK8E8M6k
         BjqIxqhVZZqxnbXGWFR/tfuF601f9FSyqshkjCF+VAObqPorud2gRVSLzTAsCQdu+LWx
         8hanTp1/MaRVAo9+6bkbPlWbJldS+leefB/X63lk4MZvsJ29GKuP61b6M+iYqqY+tjrP
         6f2Uzr4tbxQdMQqH5kpht25Q/i7xn3XXF7sd0U36aaOnR2TWbetaa5nK4omQHcy6Imkq
         5iT9P935UCWlHiLN0anZqoTW+jn2p950KWrbklX07HUev9jN2+4mzrwVg8pHS664oXtO
         c0HA==
X-Forwarded-Encrypted: i=1; AKwUvBwgca4GpICDZNxZEokyLWs3a0xff+NHnX/tjC1DbwpVbOQ1MC6IuCXBEVh+hitUYHl1e+punCaSEJi9nBQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9B6Sv9uABXdkhaPPOqCNDb/dfcIrsnt5xmLDu8GICAX8tNjynb
	5wLdskzSzTyXExIV7uQGywT6TpXKMozr43vdAr7nwBUf7XRFVunRx84=
X-Gm-Gg: AYBFou2QcJKa2hzJCrw/H9UUKKFpr+Sc0whYa/9V+g7LhR4WNxHOlUqPzB8XICuc8pK
	3aQCzzl6qAGaOwRl7BsVpMq/7Qo4TTJFT6mn/oZh9MLQm7y8E9ZhEiBsqctIwx5H9whoIdLuxLt
	HzE4Jqds9Mvc9cgZpiaG//FmmF01+u+n1sZsJOF95SHpBrkQ7YaM73R9lfa14YYW8+ePbcAX8cB
	d+qQBOePS+NwSFfkPW1i814N3wGtOFHsxysBP87LQSzM/ne+yVvK6/+tP3BcMgRvRb344GzrRxu
	fbm+9iMDg0WQeT7CKeRIjFwzhTIS7BnyetNYXLxHAAh/bYQcvzQoshuWCADz7XaJbZ053+onMke
	eAlJ8tgREhcHIBCLUEXX0Q/Mm+ObimrRUguFe20Myndo1iwKrYO1SrPHlkDAjQRxnpDpImeVIrG
	EAdTztmdL8wFi9ZKYY086jZxBIIugXHJuzbuvxj+Xsik/kVp5BPRhI/F5vOpLnBYpe8ry+8FgGI
	LRN/Dk/HGnsRkgOblULjN0qX8orjhu9NOhRBcK+mubq9lzYOcrG4lRRiWnSGGq72+dMQ3N5cE3c
	TtvnZ8zBjDDpwfq7ynnB2AgWnx3385yatk8yopMhLzvTfiaTfmd0
X-Received: by 2002:a17:90b:2e52:b0:3ab:24b2:9016 with SMTP id 98e67ed59e1d1-3ae897ec759mr15992932a91.25.1793865862020;
        Thu, 05 Nov 2026 00:04:22 -0800 (PST)
Received: from localhost.localdomain ([202.51.247.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b328a04asm2617818a91.14.2026.11.05.00.04.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 00:04:21 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: linux-fsi@lists.ozlabs.org
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] fsi: aspeed: release the master device node with the device
Date: Thu,  5 Nov 2026 16:04:14 +0800
Message-ID: <rc-review-20261105-32-59f96c1fdaf1@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260913060242.1426845-1-lgs201920130244@gmail.com>
References: <20260916093914.2005582-1-vulab@iscas.ac.cn> <20260913060242.1426845-1-lgs201920130244@gmail.com>
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

fsi_master_aspeed_probe() takes a node reference for master.dev.
The posted error-path fix releases it before directly freeing the
allocation, but the successful registration path still retains it
when the master device is finally released.

Put the node in aspeed_master_release() before freeing the containing
object. With the posted remove-path device put, this keeps the node
valid until the last master-device user is gone and balances the
successful path without repeating the error-path put.

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Link: https://patchwork.kernel.org/series/1166294/
Link: https://patchwork.kernel.org/series/1163700/
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261102 (2637bdec0535).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_OF_DYNAMIC=y.
COMPILE_TEST=y.
Baseline and patched target objects built from this exact base.
No full kernel/module-link, hardware or runtime test was performed.
AI assistance was used for analysis and patch preparation.

This is an incremental patch based on the following posted fixes:
  [PATCH] fsi: master-aspeed: Fix of_node reference leak in fsi_master_aspeed_probe()
  <20260916093914.2005582-1-vulab@iscas.ac.cn>
  [PATCH] fsi: aspeed: fix memory leak on remove
  <20260913060242.1426845-1-lgs201920130244@gmail.com>

 drivers/fsi/fsi-master-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index f0bd760fa78b..cac0a8c73043 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -378,6 +378,7 @@ static void aspeed_master_release(struct device *dev)
 	struct fsi_master_aspeed *aspeed =
 		to_fsi_master_aspeed(to_fsi_master(dev));
 
+	of_node_put(dev->of_node);
 	kfree(aspeed);
 }
 

base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
prerequisite-patch-id: 0d97a848987c2bd4195686f43f69a0d0c0f69608
prerequisite-patch-id: 00d7444e3a96e93c967d233b9c7c3a79c54647e9

