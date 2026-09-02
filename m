Return-Path: <linux-aspeed+bounces-4924-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB18C61DD6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:18:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0ZC3tHZz2y22;
	Thu, 03 Sep 2026 10:18:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380292;
	cv=none; b=iRTFXDSMHlFOC0KGxEngqb6xsuFJBzO/OSHCoW7iaTWOGp58M/6xBiGYAybcyxkZfbLaLFLLkQww3OEamA0WUfV+U+vQarWre8j3zzQrarf9nYhT648exhIdMpjeb9vooEwXxVDplbmRl4Ar8ofK5nYA4RhsRwV5GZkcfQZPKzYwA/D+viJJV9liXs79od56JVarcImIugN1h+sKn3Ue7lk/IGUiEZGqqdDpIqBRL4JKv9gVfU33hRYKNzcY1L5wMd2s0IVCxzRtk/R308S9CbWIWhY6EHqnIjNS+3khbaRPFXiXh2Zr0hUMkeAam0MLFjr6n1YXPprvXHRGE2sXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380292; c=relaxed/relaxed;
	bh=1oZVnfNKBlFgiLoC1iu2FLkuJ+ivoENKb0cGsDY70+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0KLl628DN+f6MeG1NXliqu2o7SsHkjJ+pkyRBgih0lkePzNkSsyY9HV80Bdf1k3Ys90zNoPEBWQx3Vn4TI1hZOuRyCeoc2tv3Ef3BQxe4iZZgBhieT7ujaAJuBeIzQ8ws5bCHh23CwHtuznG5As9EpVfA/53vKer3Kiagg+H5AVcf+FOPGOtQEcK974lAcfDsFGP2HvN2M5IuBsa0va9QLT5ZpqNLd5+QTx2miuTOGfm+mfID7a1i7Z5sEKWhAbktNSvERPDUhUP8iz9wwetT3JCZw1jRNbu9X0bXIQyu9NQPCjEz9ydnoHAD60nxeFVnMk+KZ4mtsmr5fYJ4t7hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j1mAbS1W; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RHb+MrSs; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j1mAbS1W;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RHb+MrSs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZvDh0xkYz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:18:11 +1000 (AEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHRWs3044794
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1oZVnfNKBlF
	giLoC1iu2FLkuJ+ivoENKb0cGsDY70+s=; b=j1mAbS1WwfUQzBqYP4YaGonJ+T4
	V6thqxNqjhIzlgurylVjTlfyJZSSx1MPoTQW+WhdcuCa671cADb5o4lEppbNkINg
	TtkwmDTl/CqQnuLj5+fhseH5ZAKcISvU19C3g+b+wmJossW1jTj4R/jJUU6LlSpT
	DynUEriHFzK7gm5Zf6v535ockse4QpLNoVFuzoMNfEseuW1jQbYOg4w42n6YtYtI
	qulXr/KcFR0lGSJlAv/bSjvIviKn2nbcjixPH+BTYJIjD2IoDPycDXWUY/bZcJhk
	M4Hdd6KE3FnU45yCKveXXDWsxiO+ZgXjOcw5u2VwllK623xZ0443Sk9K3fA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy2tav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:18:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee1ec30f2so19113845ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380288; x=1788985088; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1oZVnfNKBlFgiLoC1iu2FLkuJ+ivoENKb0cGsDY70+s=;
        b=RHb+MrSs/4IiL29keL+P+URv/3MW81bzpcL5UE9aRgW6ESja2A5djKJosw36HJPcNy
         vtR16cplJjXiTdOTEZ1VAfU/2UT7K/ssmjCSoAgIYxo9PRzFGhvrIvIEDDOjy1mPKOyR
         qOZavcqS4PtKG1/TvuiuUVPwAVMxpeRWhKC4boJzlvs7pvfFUZr/xow0MXec6/k6QlA6
         uRZKfQ0e3thJl8N5qDxU7s0hn6/VlJf7swmPdlXIYlgybjRc1ruPd2F8odweVMwV/678
         6eiiw/d/MPC2UWc59+aI/low7MSM9ne3lbChGVlgwMHp78jllhZ7ZWeWHipjQLY1y1Hh
         caew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380288; x=1788985088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1oZVnfNKBlFgiLoC1iu2FLkuJ+ivoENKb0cGsDY70+s=;
        b=r10em66+6/82kD7zWXLMvXVrgGhYtNEpiVi5pKxfSEoMHw71/Ndd5izq/Vy9JT0bXI
         ls2Roc9kAE8OlwEJnvNQXt7Vl2ug+b2CWahUMTfcIGSJTYXQ4A5UjMP9re/Z0lSiNwPg
         Shfb/pvdqlJ+8O80APSSD7vkl5JqrsaeIsCnlLLRBSChyKMveq4rWfVWGl+/zmgDAflE
         YWU5VPk1LSVvDNbxd5x9cKPlk4/P2JBWv/OukyZHKh3+gzvqn+Dwg+3NWLoS8Z6gMGi/
         5oY1KlZNvZ1KI9xyy3pnsfrYgqTmtjnjZQHgWzZSctvVzInNEvNZAvis11ez899vAbGZ
         q5rg==
X-Forwarded-Encrypted: i=1; AKwUvBy4OAgrKjDzLnJiageqdDL1p3Pfzt6Gqa3UDA+W2MbEC//6I7HSTO1sdznhujd++8mJKDzA+6Xd/MOnLWQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kkhnE18NQy1fb4NORVFx4YBthQj12ycImFwShSvtUpHhyM1d7B
	vokzQGIKFwXGn9/eAPdIRme5c6FVfpSmj3jc9hhAjm6UPeaQW2cqE/bIkJmHTCDhn0C53QqA2eo
	z42xJ6WTQCO/kj1QjkdNnCYfpkcffnhQJup7dNh9G8rfGp2H1dlZKCg1YQ5h893K5liAH
X-Gm-Gg: AYBFou3LYS0zVwFOVYnHsqBXaRk6OZUW2t5nOLVSV2rsYOg07G2/jAYhV2RwkNPIkhj
	hwb0MQFtVOIKmyZTEXn+VwoZRVFKuSNnCi7/FgpcYdeJSgrxBgT/4WFzqUnOKKHWw+gVcon/een
	YjH5PFrJR3XkvFNi44qf6n/v2Ip7cporzm79hLM3i5LtLvHgll/UAtLbAopCZ6K7TsFBUl+0TIr
	4ltbSO0ZfCMh23rdBqxdhuzHzbTl9yJmFLiytbUovytEFAiYCN4e7KdO9caO5L5sCDtcLH81zH7
	zeyuX+EfYvKaAk2sB1l1qjbeQcCMN1c4JEqorYyDQEBpABQZe0tg+UX3VwwlrhJqUkfcK6GhdvA
	yrZDFZOhrzum3kislkghUC4CgAQc=
X-Received: by 2002:a17:903:9cc:b0:2da:ef81:37e7 with SMTP id d9443c01a7336-2daef813b09mr84025035ad.21.1788380288460;
        Wed, 02 Sep 2026 13:18:08 -0700 (PDT)
X-Received: by 2002:a17:903:9cc:b0:2da:ef81:37e7 with SMTP id d9443c01a7336-2daef813b09mr84024465ad.21.1788380287974;
        Wed, 02 Sep 2026 13:18:07 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:18:07 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Paul Cercueil <paul@crapouillou.net>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v2 9/11] drm: xlnx: zynqmp_dpsub: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:38 +0530
Message-ID: <20260902201640.2024648-10-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a988481 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=zd2uoN0lAAAA:8
 a=EUspDBNiAAAA:8 a=QbF1duAvIEq2M5YqX_oA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: AttvqZq1GmWV4-erQqlCSajcsYkh6Jhf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXxcECJdZ0UK+8
 nBPthPLbVYqg6ggnXjpKoJAF5Ck7CM1REp1trhTTZ1V8GhpyYAl3ZAPqbANhHoy7Afjo6BrxAiL
 ezKY5j+kH3Yu6QdsUSPE0fwueD746AI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXxQXB8aGep5y2
 KOWc3SkRCq5gQjU5gy2uIX850ssKHezIXTiNZFx1HoulxIJcga5iyuYHLsxYl7e9fA6VprcHVNr
 XaOoA3UtxOTpgspgr31nCpSftXiEX4iiIivsmcj0ZkJCSRyvwZCEtw3dF5jr+2kvG18+MO3N9Bd
 8791xwuQhNBMh20Jet8ZTmvZtGgVv2uD7uIYBiBOoT6VY30mfHybqkLeImWZ0yRB7N1v2dB83AJ
 5cWW6uDKWMcET46LcyfNfCsQ4v/HOzx8DdzV21esQ7y4pLLnjvDrxuu9xK9Db52ng5bFV5FVkSm
 xXJuke1d3LbgIWETjdgXEajXaZaNd2Kwh5iXzqp/8mUyRo8pHfq0umvtgmsLLSihjFe93nwgoNy
 SgEAR69J1teYAbTTz3A/oyig85zaW5YORSRB5MuFZ7HdiPCf9HZtmM3x3Dq08e8StOl5ytDv5oh
 C2rEaLa8HMVln0w7TJA==
X-Proofpoint-ORIG-GUID: AttvqZq1GmWV4-erQqlCSajcsYkh6Jhf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index 53ab1a2a5aaf..e93a7a299b52 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -203,7 +203,7 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 
 	/* Try the reserved memory. Proceed if there's none. */
-	of_reserved_mem_device_init(&pdev->dev);
+	devm_of_reserved_mem_device_init(&pdev->dev);
 
 	ret = zynqmp_dpsub_init_clocks(dpsub);
 	if (ret < 0)
@@ -255,7 +255,6 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dpsub->apb_clk);
 err_mem:
-	of_reserved_mem_device_release(&pdev->dev);
 	if (!dpsub->drm)
 		zynqmp_dpsub_release(dpsub);
 	return ret;
@@ -276,7 +275,6 @@ static void zynqmp_dpsub_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dpsub->apb_clk);
-	of_reserved_mem_device_release(&pdev->dev);
 
 	if (!dpsub->drm)
 		zynqmp_dpsub_release(dpsub);
-- 
2.55.0


