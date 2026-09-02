Return-Path: <linux-aspeed+bounces-4950-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209B9C624D6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:29:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0pH1yfmz2yr2;
	Thu, 03 Sep 2026 10:29:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788379688;
	cv=none; b=cSuYfN86mXz4g9J6M186uuUNNbj8dPHVbymRXUggWv8dKZhDCL9sSL7acZXOqU4CqSOMCFqdNTW+EU948wPaljnTkgR/v8XuTic516pQpX6w2CQf3OJANaapxbAOqmcBUhqgrDjfxqa5ySFXRhTkVviwSjP6o76VzMlK4fvC0r7hbFhSwWqsr3xFy7gKZSO3NvHQYc4XkQ89OLvbo8HUUZOEBFlDwrmXgUpk/3dxoGDg6/cMpKZrf95B7VT5xD8OjYhzQMBeZ34N1zgFu1aImEssbVK17NxxwQD5kVFbBUxv8EEFoOITbBphiUmUE+0B1RPtoF7aBbvsWFbuGO9m0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788379688; c=relaxed/relaxed;
	bh=V62NrpgUOu9gE+yVRqH4AGEITpcms2N1p3z2wjAcl1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWAInx3jilBTsFPolydRCfWZrAWZp50uVmRKTQGOFrol6Q3+LqduVPjf5lUC/tmSUqlQy8hKV7yQ+n39sgsiMp5egRrJZEjEEEB0H7vwXFPVENXNUuOi/RQuwg0t83GnGjAr+PuaIP/hY70wfRlHYvXmBJxS/rE3+GV8OOjx1a3mzer4NROQz4e4qgWjIh6OOwsa81TQy/+jxzuXvWkhEItVcXxqhCDVObGE6w0fguUDDimtNsKL7St6Nj0eC3czfc8ncQttlh1qwnj4GqDmpqeJi9hZdkmM2U3j1j/tK/A99DA2inLVsxpjR7qezvnlibofxZKEMlnLlY2YLQCWRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tz3iT1Z0; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dHipRfQZ; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tz3iT1Z0;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dHipRfQZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZv135ld4z2ypW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:08:07 +1000 (AEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HrlSP2731033
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V62NrpgUOu9
	gE+yVRqH4AGEITpcms2N1p3z2wjAcl1Y=; b=Tz3iT1Z08cE3L1Tsg6uwOfDDlUn
	OlK172bribh74PRXIRNSvRLnJcuTmAmGXtzeJq5+oXtGDt24T0SgWNFTKMUvsN2c
	o3xyvGkqECHDErCIEqxM99+VAwarBlIDHogFfV74HBGoCmSh/+CnU44qEFsEgMc0
	LpF2U7coKzkS1YPs0gz7Hbj/JooKnj6bCPL8V1vKhdMaLff6/5fMHjACVdDv2QJu
	tO6X72JpKItRX+1tQrpTgNjGGbGiD905GrptgN/0LH1HTDuNsrLJCjw3enNv9gfP
	TCtWu6AsZWs5xIO4Z0Gu480RmSQw51flp895ecr+MPU1PEDsQtnsH27/A+g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy2s6m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:08:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d55d8cd938so25692085ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788379684; x=1788984484; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V62NrpgUOu9gE+yVRqH4AGEITpcms2N1p3z2wjAcl1Y=;
        b=dHipRfQZdeWPxndHLEnpXsDp8iahRkLRTD2IFRLnxdHptqFGlIsX6HNkZrhPK7BDXt
         j26rIZgnmUNN2ElI/OQ+mPGFNbNIYaH9SbTWr6K8UPNWyMJLLRUEwezrnCXLc9ja+CUs
         MdrZ+40RImhpiX7ug7K9z4G/yCoF8HZQ2TMWtMuv8v41Q+bvDBIpn2twZDZ4y+g4bhz2
         /F8w0u/H9eJxkx+551eTLcnmjrf8vBWr0FgK+cGUsqrQg2PDfGbUQV4ku/3LOoIYEc4t
         p6+5/wy1GSBaSoCJPuZJBXA0/GUxh9bYFnzPEYDbKNr0ErrX7Ne+ZA3BQqUyEYw8GDyY
         RZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788379684; x=1788984484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V62NrpgUOu9gE+yVRqH4AGEITpcms2N1p3z2wjAcl1Y=;
        b=LO9Yoi8cN0/XbNw8uzwL0x2OSsDkCZXY7FaO1BFHCptsUIkERwCouFcpAj7TrMXzWE
         xfqUngp78CSOOT8UpBxce+03W3Qyy7v8IEVSnFZ4nDfXJ1I1zn9yPLtIQ7Ww/xkJk4vT
         X8M04lcHbQpIQDVF2Z3DhVUyE1Jbb3nyDzsWIP49pGeGfJeBKvGGrD7kIr6xphGWdC21
         vpkZ7pgeQKxljzM5ny3CDItiZ5EZXo6ktu0/ZJf4a3IA0VzsgWR5a95RHQbyO5okuRPx
         WjblTNCty3L+/pMUWUzHGiV+nFkqXpGE/xmQvDsySeajpmuKdkCWo4N7NwsenKzJ63nz
         Alvw==
X-Forwarded-Encrypted: i=1; AKwUvBw88YDfeptlsKO9+SmjvQ5XSnwysY1p2FBLRXX/ciUneEzp9br7gjCRYxuS6ZM1xqVe7LDLvYhYJ+iYAs8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nBd+S+cy4C+inlY+JvjSn7XbkSrVSR3Jen06y3yEtNM1/H0tLW
	0sC9nLWdut6ZeFLXkahYxQycBjU4ehIJs/i+mzLe/lDATqZ5nF5YaMaHr3rNpUhlDIFhbxfMg0q
	1kyJa/K1dzEhzO1jMv+YSdrRcJi49FFjpOnhEQg9K0ioq2NfDhepOLtGPTv08xeYf4fzl
X-Gm-Gg: AYBFou38JvHK35rgJURqMO3mHjkKy1Z0lqF8rxKWJPHImiGhQPi9yEBb7wQs+TLpeIi
	51sEvCwgyLjvO5noF9bNRIwVY+OwNDgo8JodxdB3MaTe8s7Y9218GBme5du3vpaAh+7UCOljF5E
	yA1pgNulgHv9Fq9g060QM5ItgSXk3zPvw5VWtbDH3wwHFFrsFaP5ozYzIlIs91TMyqLbLH5mCgV
	JFX+fhrud0bcjbdx8L2G3bpG6T3xD9iewyD6Swjmkyb2g0vKH04M2PIZe4Kwq7alnupM8Ksj2FG
	P43lCZ7eYjMkTlsuNV89JiRxONff0KJgoOzetzBRFrzH21RxvZVb8unSVZEAQg5Px7GY735MKI4
	nFljtUhFSTt7HasAERyHjjBwWXDU=
X-Received: by 2002:a17:903:283:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2daec5ad515mr80446035ad.4.1788379683920;
        Wed, 02 Sep 2026 13:08:03 -0700 (PDT)
X-Received: by 2002:a17:903:283:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2daec5ad515mr80445245ad.4.1788379683366;
        Wed, 02 Sep 2026 13:08:03 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33255f2981dsm434360eec.19.2026.09.02.13.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:08:02 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Daniel Scally <dan.scally@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 4/6] media: arm: mali-c55: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:37:01 +0530
Message-ID: <20260902200703.2016410-5-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902200703.2016410-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902200703.2016410-1-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a988224 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=YVK2hjuZJVh9DdmUNrMA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: aMoGHxj5OmLsUi-uXgcDzv4R_d-3t3jb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OCBTYWx0ZWRfX0DQK4cCasKTm
 yfqcN1/UR6gYBRr/nApdorfAWLXonTMmDKL8iONSuPQhzR7guqnsIDkPU2YS4ckSCnjofqLhh34
 aryEZ251SBZhKW04Hhht7ZnHvndzSpw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OCBTYWx0ZWRfX0Vr24mYMjjHx
 NnCba9UKaOtdcBXSmlprT2HvauTvgBkCnjSnstTF4K4fk4C5J2XFayfJtnrIW/61xGbE0fAZwNB
 4obiRKArkJUfXq686W9e7PysyblsL1FrVoNw3JfwyjPWuKmNT/iw8ofaDQLce49orlRZxBUcTXr
 14jZ1Tx+sWz/Qsle7DcWlX2wKQo0nud96O3thjIeJWJmP51ZL2SnXYVBvanWko+MLNb5ECm/87E
 5IGRIvcax2NEOqmRZFnDC9+HlCDeXHj9LHEJlfMBl4rJBpBwC4+3sle7q3m2RYgkI6eilJk8tJa
 ycnl95qhfwWzgv3rVj4lXuj5LX5q/Dwn1E5bl3g8Py/S1FFco3xxz9OeVFHLA3R5bnuu/ZA7fZ6
 masnWjvKMs9MDw5FAG0ARe4Y4dXV1xKluGBKsp9iqPldJwroouL3O5YdmvPstBzrjHP6IXApjiz
 eRnaJvQQ/fmy8Zc3jYQ==
X-Proofpoint-ORIG-GUID: aMoGHxj5OmLsUi-uXgcDzv4R_d-3t3jb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020178

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/arm/mali-c55/mali-c55-core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
index f28e9f4354ac..3d37cd446583 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
@@ -803,14 +803,12 @@ static int mali_c55_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to acquire resets\n");
 
-	of_reserved_mem_device_init(dev);
+	devm_of_reserved_mem_device_init(dev);
 	vb2_dma_contig_set_max_seg_size(dev, UINT_MAX);
 
 	ret = __mali_c55_power_on(mali_c55);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to power on\n");
-		goto err_release_mem;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to power on\n");
 
 	ret = mali_c55_check_hwcfg(mali_c55);
 	if (ret)
@@ -849,9 +847,6 @@ static int mali_c55_probe(struct platform_device *pdev)
 	kfree(mali_c55->context.registers);
 err_power_off:
 	__mali_c55_power_off(mali_c55);
-err_release_mem:
-	of_reserved_mem_device_release(dev);
-
 	return ret;
 }
 
@@ -866,7 +861,6 @@ static void mali_c55_remove(struct platform_device *pdev)
 	}
 	pm_runtime_disable(&pdev->dev);
 	kfree(mali_c55->context.registers);
-	of_reserved_mem_device_release(&pdev->dev);
 }
 
 static const struct of_device_id mali_c55_of_match[] = {
-- 
2.55.0


