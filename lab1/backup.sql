--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0 (Debian 16.0-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: fill_category(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.fill_category() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    i INTEGER := 0;
BEGIN
    WHILE i < 1000 LOOP -- создаст 1000 записей
        INSERT INTO category (category_name) VALUES ('Category ' || i);
        i := i + 1;
    END LOOP;
END;
$$;


ALTER FUNCTION public.fill_category() OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: category; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.category (
    category_id integer NOT NULL,
    parent_category integer,
    category_name character varying(255) NOT NULL
);


ALTER TABLE public.category OWNER TO admin;

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.category_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_category_id_seq OWNER TO admin;

--
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category.category_id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    user_id integer,
    payment_date timestamp without time zone DEFAULT now() NOT NULL,
    amount numeric(10,2) NOT NULL
);


ALTER TABLE public.payments OWNER TO admin;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_payment_id_seq OWNER TO admin;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- Name: price_change; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.price_change (
    change_id integer NOT NULL,
    product_id integer,
    date_price_change timestamp without time zone DEFAULT now() NOT NULL,
    new_price numeric(10,2) NOT NULL
);


ALTER TABLE public.price_change OWNER TO admin;

--
-- Name: price_change_change_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.price_change_change_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.price_change_change_id_seq OWNER TO admin;

--
-- Name: price_change_change_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.price_change_change_id_seq OWNED BY public.price_change.change_id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.product (
    product_id integer NOT NULL,
    product_name character varying(255) NOT NULL,
    path_to_file text,
    description text,
    is_active boolean NOT NULL,
    data_product_create timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.product OWNER TO admin;

--
-- Name: product_category; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.product_category (
    product_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.product_category OWNER TO admin;

--
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.product_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_product_id_seq OWNER TO admin;

--
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.product_product_id_seq OWNED BY public.product.product_id;


--
-- Name: purchase; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.purchase (
    purchase_id integer NOT NULL,
    purchase_date timestamp without time zone DEFAULT now() NOT NULL,
    customer_id integer,
    product_id integer,
    product_price numeric(10,2) NOT NULL
);


ALTER TABLE public.purchase OWNER TO admin;

--
-- Name: purchase_purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.purchase_purchase_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_purchase_id_seq OWNER TO admin;

--
-- Name: purchase_purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.purchase_purchase_id_seq OWNED BY public.purchase.purchase_id;


--
-- Name: user_service; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_service (
    user_id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    balance numeric(10,2) DEFAULT 0
);


ALTER TABLE public.user_service OWNER TO admin;

--
-- Name: user_service_user_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.user_service_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_service_user_id_seq OWNER TO admin;

--
-- Name: user_service_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.user_service_user_id_seq OWNED BY public.user_service.user_id;


--
-- Name: category category_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.category ALTER COLUMN category_id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- Name: price_change change_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.price_change ALTER COLUMN change_id SET DEFAULT nextval('public.price_change_change_id_seq'::regclass);


--
-- Name: product product_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_product_id_seq'::regclass);


--
-- Name: purchase purchase_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.purchase ALTER COLUMN purchase_id SET DEFAULT nextval('public.purchase_purchase_id_seq'::regclass);


--
-- Name: user_service user_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_service ALTER COLUMN user_id SET DEFAULT nextval('public.user_service_user_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.category (category_id, parent_category, category_name) FROM stdin;
1	\N	Category 0
2	\N	Category 1
3	\N	Category 2
4	\N	Category 3
5	\N	Category 4
6	\N	Category 5
7	\N	Category 6
8	\N	Category 7
9	\N	Category 8
10	\N	Category 9
11	\N	Category 10
12	\N	Category 11
13	\N	Category 12
14	\N	Category 13
15	\N	Category 14
16	\N	Category 15
17	\N	Category 16
18	\N	Category 17
19	\N	Category 18
20	\N	Category 19
21	\N	Category 20
22	\N	Category 21
23	\N	Category 22
24	\N	Category 23
25	\N	Category 24
26	\N	Category 25
27	\N	Category 26
28	\N	Category 27
29	\N	Category 28
30	\N	Category 29
31	\N	Category 30
32	\N	Category 31
33	\N	Category 32
34	\N	Category 33
35	\N	Category 34
36	\N	Category 35
37	\N	Category 36
38	\N	Category 37
39	\N	Category 38
40	\N	Category 39
41	\N	Category 40
42	\N	Category 41
43	\N	Category 42
44	\N	Category 43
45	\N	Category 44
46	\N	Category 45
47	\N	Category 46
48	\N	Category 47
49	\N	Category 48
50	\N	Category 49
51	\N	Category 50
52	\N	Category 51
53	\N	Category 52
54	\N	Category 53
55	\N	Category 54
56	\N	Category 55
57	\N	Category 56
58	\N	Category 57
59	\N	Category 58
60	\N	Category 59
61	\N	Category 60
62	\N	Category 61
63	\N	Category 62
64	\N	Category 63
65	\N	Category 64
66	\N	Category 65
67	\N	Category 66
68	\N	Category 67
69	\N	Category 68
70	\N	Category 69
71	\N	Category 70
72	\N	Category 71
73	\N	Category 72
74	\N	Category 73
75	\N	Category 74
76	\N	Category 75
77	\N	Category 76
78	\N	Category 77
79	\N	Category 78
80	\N	Category 79
81	\N	Category 80
82	\N	Category 81
83	\N	Category 82
84	\N	Category 83
85	\N	Category 84
86	\N	Category 85
87	\N	Category 86
88	\N	Category 87
89	\N	Category 88
90	\N	Category 89
91	\N	Category 90
92	\N	Category 91
93	\N	Category 92
94	\N	Category 93
95	\N	Category 94
96	\N	Category 95
97	\N	Category 96
98	\N	Category 97
99	\N	Category 98
100	\N	Category 99
101	\N	Category 100
102	\N	Category 101
103	\N	Category 102
104	\N	Category 103
105	\N	Category 104
106	\N	Category 105
107	\N	Category 106
108	\N	Category 107
109	\N	Category 108
110	\N	Category 109
111	\N	Category 110
112	\N	Category 111
113	\N	Category 112
114	\N	Category 113
115	\N	Category 114
116	\N	Category 115
117	\N	Category 116
118	\N	Category 117
119	\N	Category 118
120	\N	Category 119
121	\N	Category 120
122	\N	Category 121
123	\N	Category 122
124	\N	Category 123
125	\N	Category 124
126	\N	Category 125
127	\N	Category 126
128	\N	Category 127
129	\N	Category 128
130	\N	Category 129
131	\N	Category 130
132	\N	Category 131
133	\N	Category 132
134	\N	Category 133
135	\N	Category 134
136	\N	Category 135
137	\N	Category 136
138	\N	Category 137
139	\N	Category 138
140	\N	Category 139
141	\N	Category 140
142	\N	Category 141
143	\N	Category 142
144	\N	Category 143
145	\N	Category 144
146	\N	Category 145
147	\N	Category 146
148	\N	Category 147
149	\N	Category 148
150	\N	Category 149
151	\N	Category 150
152	\N	Category 151
153	\N	Category 152
154	\N	Category 153
155	\N	Category 154
156	\N	Category 155
157	\N	Category 156
158	\N	Category 157
159	\N	Category 158
160	\N	Category 159
161	\N	Category 160
162	\N	Category 161
163	\N	Category 162
164	\N	Category 163
165	\N	Category 164
166	\N	Category 165
167	\N	Category 166
168	\N	Category 167
169	\N	Category 168
170	\N	Category 169
171	\N	Category 170
172	\N	Category 171
173	\N	Category 172
174	\N	Category 173
175	\N	Category 174
176	\N	Category 175
177	\N	Category 176
178	\N	Category 177
179	\N	Category 178
180	\N	Category 179
181	\N	Category 180
182	\N	Category 181
183	\N	Category 182
184	\N	Category 183
185	\N	Category 184
186	\N	Category 185
187	\N	Category 186
188	\N	Category 187
189	\N	Category 188
190	\N	Category 189
191	\N	Category 190
192	\N	Category 191
193	\N	Category 192
194	\N	Category 193
195	\N	Category 194
196	\N	Category 195
197	\N	Category 196
198	\N	Category 197
199	\N	Category 198
200	\N	Category 199
201	\N	Category 200
202	\N	Category 201
203	\N	Category 202
204	\N	Category 203
205	\N	Category 204
206	\N	Category 205
207	\N	Category 206
208	\N	Category 207
209	\N	Category 208
210	\N	Category 209
211	\N	Category 210
212	\N	Category 211
213	\N	Category 212
214	\N	Category 213
215	\N	Category 214
216	\N	Category 215
217	\N	Category 216
218	\N	Category 217
219	\N	Category 218
220	\N	Category 219
221	\N	Category 220
222	\N	Category 221
223	\N	Category 222
224	\N	Category 223
225	\N	Category 224
226	\N	Category 225
227	\N	Category 226
228	\N	Category 227
229	\N	Category 228
230	\N	Category 229
231	\N	Category 230
232	\N	Category 231
233	\N	Category 232
234	\N	Category 233
235	\N	Category 234
236	\N	Category 235
237	\N	Category 236
238	\N	Category 237
239	\N	Category 238
240	\N	Category 239
241	\N	Category 240
242	\N	Category 241
243	\N	Category 242
244	\N	Category 243
245	\N	Category 244
246	\N	Category 245
247	\N	Category 246
248	\N	Category 247
249	\N	Category 248
250	\N	Category 249
251	\N	Category 250
252	\N	Category 251
253	\N	Category 252
254	\N	Category 253
255	\N	Category 254
256	\N	Category 255
257	\N	Category 256
258	\N	Category 257
259	\N	Category 258
260	\N	Category 259
261	\N	Category 260
262	\N	Category 261
263	\N	Category 262
264	\N	Category 263
265	\N	Category 264
266	\N	Category 265
267	\N	Category 266
268	\N	Category 267
269	\N	Category 268
270	\N	Category 269
271	\N	Category 270
272	\N	Category 271
273	\N	Category 272
274	\N	Category 273
275	\N	Category 274
276	\N	Category 275
277	\N	Category 276
278	\N	Category 277
279	\N	Category 278
280	\N	Category 279
281	\N	Category 280
282	\N	Category 281
283	\N	Category 282
284	\N	Category 283
285	\N	Category 284
286	\N	Category 285
287	\N	Category 286
288	\N	Category 287
289	\N	Category 288
290	\N	Category 289
291	\N	Category 290
292	\N	Category 291
293	\N	Category 292
294	\N	Category 293
295	\N	Category 294
296	\N	Category 295
297	\N	Category 296
298	\N	Category 297
299	\N	Category 298
300	\N	Category 299
301	\N	Category 300
302	\N	Category 301
303	\N	Category 302
304	\N	Category 303
305	\N	Category 304
306	\N	Category 305
307	\N	Category 306
308	\N	Category 307
309	\N	Category 308
310	\N	Category 309
311	\N	Category 310
312	\N	Category 311
313	\N	Category 312
314	\N	Category 313
315	\N	Category 314
316	\N	Category 315
317	\N	Category 316
318	\N	Category 317
319	\N	Category 318
320	\N	Category 319
321	\N	Category 320
322	\N	Category 321
323	\N	Category 322
324	\N	Category 323
325	\N	Category 324
326	\N	Category 325
327	\N	Category 326
328	\N	Category 327
329	\N	Category 328
330	\N	Category 329
331	\N	Category 330
332	\N	Category 331
333	\N	Category 332
334	\N	Category 333
335	\N	Category 334
336	\N	Category 335
337	\N	Category 336
338	\N	Category 337
339	\N	Category 338
340	\N	Category 339
341	\N	Category 340
342	\N	Category 341
343	\N	Category 342
344	\N	Category 343
345	\N	Category 344
346	\N	Category 345
347	\N	Category 346
348	\N	Category 347
349	\N	Category 348
350	\N	Category 349
351	\N	Category 350
352	\N	Category 351
353	\N	Category 352
354	\N	Category 353
355	\N	Category 354
356	\N	Category 355
357	\N	Category 356
358	\N	Category 357
359	\N	Category 358
360	\N	Category 359
361	\N	Category 360
362	\N	Category 361
363	\N	Category 362
364	\N	Category 363
365	\N	Category 364
366	\N	Category 365
367	\N	Category 366
368	\N	Category 367
369	\N	Category 368
370	\N	Category 369
371	\N	Category 370
372	\N	Category 371
373	\N	Category 372
374	\N	Category 373
375	\N	Category 374
376	\N	Category 375
377	\N	Category 376
378	\N	Category 377
379	\N	Category 378
380	\N	Category 379
381	\N	Category 380
382	\N	Category 381
383	\N	Category 382
384	\N	Category 383
385	\N	Category 384
386	\N	Category 385
387	\N	Category 386
388	\N	Category 387
389	\N	Category 388
390	\N	Category 389
391	\N	Category 390
392	\N	Category 391
393	\N	Category 392
394	\N	Category 393
395	\N	Category 394
396	\N	Category 395
397	\N	Category 396
398	\N	Category 397
399	\N	Category 398
400	\N	Category 399
401	\N	Category 400
402	\N	Category 401
403	\N	Category 402
404	\N	Category 403
405	\N	Category 404
406	\N	Category 405
407	\N	Category 406
408	\N	Category 407
409	\N	Category 408
410	\N	Category 409
411	\N	Category 410
412	\N	Category 411
413	\N	Category 412
414	\N	Category 413
415	\N	Category 414
416	\N	Category 415
417	\N	Category 416
418	\N	Category 417
419	\N	Category 418
420	\N	Category 419
421	\N	Category 420
422	\N	Category 421
423	\N	Category 422
424	\N	Category 423
425	\N	Category 424
426	\N	Category 425
427	\N	Category 426
428	\N	Category 427
429	\N	Category 428
430	\N	Category 429
431	\N	Category 430
432	\N	Category 431
433	\N	Category 432
434	\N	Category 433
435	\N	Category 434
436	\N	Category 435
437	\N	Category 436
438	\N	Category 437
439	\N	Category 438
440	\N	Category 439
441	\N	Category 440
442	\N	Category 441
443	\N	Category 442
444	\N	Category 443
445	\N	Category 444
446	\N	Category 445
447	\N	Category 446
448	\N	Category 447
449	\N	Category 448
450	\N	Category 449
451	\N	Category 450
452	\N	Category 451
453	\N	Category 452
454	\N	Category 453
455	\N	Category 454
456	\N	Category 455
457	\N	Category 456
458	\N	Category 457
459	\N	Category 458
460	\N	Category 459
461	\N	Category 460
462	\N	Category 461
463	\N	Category 462
464	\N	Category 463
465	\N	Category 464
466	\N	Category 465
467	\N	Category 466
468	\N	Category 467
469	\N	Category 468
470	\N	Category 469
471	\N	Category 470
472	\N	Category 471
473	\N	Category 472
474	\N	Category 473
475	\N	Category 474
476	\N	Category 475
477	\N	Category 476
478	\N	Category 477
479	\N	Category 478
480	\N	Category 479
481	\N	Category 480
482	\N	Category 481
483	\N	Category 482
484	\N	Category 483
485	\N	Category 484
486	\N	Category 485
487	\N	Category 486
488	\N	Category 487
489	\N	Category 488
490	\N	Category 489
491	\N	Category 490
492	\N	Category 491
493	\N	Category 492
494	\N	Category 493
495	\N	Category 494
496	\N	Category 495
497	\N	Category 496
498	\N	Category 497
499	\N	Category 498
500	\N	Category 499
501	\N	Category 500
502	\N	Category 501
503	\N	Category 502
504	\N	Category 503
505	\N	Category 504
506	\N	Category 505
507	\N	Category 506
508	\N	Category 507
509	\N	Category 508
510	\N	Category 509
511	\N	Category 510
512	\N	Category 511
513	\N	Category 512
514	\N	Category 513
515	\N	Category 514
516	\N	Category 515
517	\N	Category 516
518	\N	Category 517
519	\N	Category 518
520	\N	Category 519
521	\N	Category 520
522	\N	Category 521
523	\N	Category 522
524	\N	Category 523
525	\N	Category 524
526	\N	Category 525
527	\N	Category 526
528	\N	Category 527
529	\N	Category 528
530	\N	Category 529
531	\N	Category 530
532	\N	Category 531
533	\N	Category 532
534	\N	Category 533
535	\N	Category 534
536	\N	Category 535
537	\N	Category 536
538	\N	Category 537
539	\N	Category 538
540	\N	Category 539
541	\N	Category 540
542	\N	Category 541
543	\N	Category 542
544	\N	Category 543
545	\N	Category 544
546	\N	Category 545
547	\N	Category 546
548	\N	Category 547
549	\N	Category 548
550	\N	Category 549
551	\N	Category 550
552	\N	Category 551
553	\N	Category 552
554	\N	Category 553
555	\N	Category 554
556	\N	Category 555
557	\N	Category 556
558	\N	Category 557
559	\N	Category 558
560	\N	Category 559
561	\N	Category 560
562	\N	Category 561
563	\N	Category 562
564	\N	Category 563
565	\N	Category 564
566	\N	Category 565
567	\N	Category 566
568	\N	Category 567
569	\N	Category 568
570	\N	Category 569
571	\N	Category 570
572	\N	Category 571
573	\N	Category 572
574	\N	Category 573
575	\N	Category 574
576	\N	Category 575
577	\N	Category 576
578	\N	Category 577
579	\N	Category 578
580	\N	Category 579
581	\N	Category 580
582	\N	Category 581
583	\N	Category 582
584	\N	Category 583
585	\N	Category 584
586	\N	Category 585
587	\N	Category 586
588	\N	Category 587
589	\N	Category 588
590	\N	Category 589
591	\N	Category 590
592	\N	Category 591
593	\N	Category 592
594	\N	Category 593
595	\N	Category 594
596	\N	Category 595
597	\N	Category 596
598	\N	Category 597
599	\N	Category 598
600	\N	Category 599
601	\N	Category 600
602	\N	Category 601
603	\N	Category 602
604	\N	Category 603
605	\N	Category 604
606	\N	Category 605
607	\N	Category 606
608	\N	Category 607
609	\N	Category 608
610	\N	Category 609
611	\N	Category 610
612	\N	Category 611
613	\N	Category 612
614	\N	Category 613
615	\N	Category 614
616	\N	Category 615
617	\N	Category 616
618	\N	Category 617
619	\N	Category 618
620	\N	Category 619
621	\N	Category 620
622	\N	Category 621
623	\N	Category 622
624	\N	Category 623
625	\N	Category 624
626	\N	Category 625
627	\N	Category 626
628	\N	Category 627
629	\N	Category 628
630	\N	Category 629
631	\N	Category 630
632	\N	Category 631
633	\N	Category 632
634	\N	Category 633
635	\N	Category 634
636	\N	Category 635
637	\N	Category 636
638	\N	Category 637
639	\N	Category 638
640	\N	Category 639
641	\N	Category 640
642	\N	Category 641
643	\N	Category 642
644	\N	Category 643
645	\N	Category 644
646	\N	Category 645
647	\N	Category 646
648	\N	Category 647
649	\N	Category 648
650	\N	Category 649
651	\N	Category 650
652	\N	Category 651
653	\N	Category 652
654	\N	Category 653
655	\N	Category 654
656	\N	Category 655
657	\N	Category 656
658	\N	Category 657
659	\N	Category 658
660	\N	Category 659
661	\N	Category 660
662	\N	Category 661
663	\N	Category 662
664	\N	Category 663
665	\N	Category 664
666	\N	Category 665
667	\N	Category 666
668	\N	Category 667
669	\N	Category 668
670	\N	Category 669
671	\N	Category 670
672	\N	Category 671
673	\N	Category 672
674	\N	Category 673
675	\N	Category 674
676	\N	Category 675
677	\N	Category 676
678	\N	Category 677
679	\N	Category 678
680	\N	Category 679
681	\N	Category 680
682	\N	Category 681
683	\N	Category 682
684	\N	Category 683
685	\N	Category 684
686	\N	Category 685
687	\N	Category 686
688	\N	Category 687
689	\N	Category 688
690	\N	Category 689
691	\N	Category 690
692	\N	Category 691
693	\N	Category 692
694	\N	Category 693
695	\N	Category 694
696	\N	Category 695
697	\N	Category 696
698	\N	Category 697
699	\N	Category 698
700	\N	Category 699
701	\N	Category 700
702	\N	Category 701
703	\N	Category 702
704	\N	Category 703
705	\N	Category 704
706	\N	Category 705
707	\N	Category 706
708	\N	Category 707
709	\N	Category 708
710	\N	Category 709
711	\N	Category 710
712	\N	Category 711
713	\N	Category 712
714	\N	Category 713
715	\N	Category 714
716	\N	Category 715
717	\N	Category 716
718	\N	Category 717
719	\N	Category 718
720	\N	Category 719
721	\N	Category 720
722	\N	Category 721
723	\N	Category 722
724	\N	Category 723
725	\N	Category 724
726	\N	Category 725
727	\N	Category 726
728	\N	Category 727
729	\N	Category 728
730	\N	Category 729
731	\N	Category 730
732	\N	Category 731
733	\N	Category 732
734	\N	Category 733
735	\N	Category 734
736	\N	Category 735
737	\N	Category 736
738	\N	Category 737
739	\N	Category 738
740	\N	Category 739
741	\N	Category 740
742	\N	Category 741
743	\N	Category 742
744	\N	Category 743
745	\N	Category 744
746	\N	Category 745
747	\N	Category 746
748	\N	Category 747
749	\N	Category 748
750	\N	Category 749
751	\N	Category 750
752	\N	Category 751
753	\N	Category 752
754	\N	Category 753
755	\N	Category 754
756	\N	Category 755
757	\N	Category 756
758	\N	Category 757
759	\N	Category 758
760	\N	Category 759
761	\N	Category 760
762	\N	Category 761
763	\N	Category 762
764	\N	Category 763
765	\N	Category 764
766	\N	Category 765
767	\N	Category 766
768	\N	Category 767
769	\N	Category 768
770	\N	Category 769
771	\N	Category 770
772	\N	Category 771
773	\N	Category 772
774	\N	Category 773
775	\N	Category 774
776	\N	Category 775
777	\N	Category 776
778	\N	Category 777
779	\N	Category 778
780	\N	Category 779
781	\N	Category 780
782	\N	Category 781
783	\N	Category 782
784	\N	Category 783
785	\N	Category 784
786	\N	Category 785
787	\N	Category 786
788	\N	Category 787
789	\N	Category 788
790	\N	Category 789
791	\N	Category 790
792	\N	Category 791
793	\N	Category 792
794	\N	Category 793
795	\N	Category 794
796	\N	Category 795
797	\N	Category 796
798	\N	Category 797
799	\N	Category 798
800	\N	Category 799
801	\N	Category 800
802	\N	Category 801
803	\N	Category 802
804	\N	Category 803
805	\N	Category 804
806	\N	Category 805
807	\N	Category 806
808	\N	Category 807
809	\N	Category 808
810	\N	Category 809
811	\N	Category 810
812	\N	Category 811
813	\N	Category 812
814	\N	Category 813
815	\N	Category 814
816	\N	Category 815
817	\N	Category 816
818	\N	Category 817
819	\N	Category 818
820	\N	Category 819
821	\N	Category 820
822	\N	Category 821
823	\N	Category 822
824	\N	Category 823
825	\N	Category 824
826	\N	Category 825
827	\N	Category 826
828	\N	Category 827
829	\N	Category 828
830	\N	Category 829
831	\N	Category 830
832	\N	Category 831
833	\N	Category 832
834	\N	Category 833
835	\N	Category 834
836	\N	Category 835
837	\N	Category 836
838	\N	Category 837
839	\N	Category 838
840	\N	Category 839
841	\N	Category 840
842	\N	Category 841
843	\N	Category 842
844	\N	Category 843
845	\N	Category 844
846	\N	Category 845
847	\N	Category 846
848	\N	Category 847
849	\N	Category 848
850	\N	Category 849
851	\N	Category 850
852	\N	Category 851
853	\N	Category 852
854	\N	Category 853
855	\N	Category 854
856	\N	Category 855
857	\N	Category 856
858	\N	Category 857
859	\N	Category 858
860	\N	Category 859
861	\N	Category 860
862	\N	Category 861
863	\N	Category 862
864	\N	Category 863
865	\N	Category 864
866	\N	Category 865
867	\N	Category 866
868	\N	Category 867
869	\N	Category 868
870	\N	Category 869
871	\N	Category 870
872	\N	Category 871
873	\N	Category 872
874	\N	Category 873
875	\N	Category 874
876	\N	Category 875
877	\N	Category 876
878	\N	Category 877
879	\N	Category 878
880	\N	Category 879
881	\N	Category 880
882	\N	Category 881
883	\N	Category 882
884	\N	Category 883
885	\N	Category 884
886	\N	Category 885
887	\N	Category 886
888	\N	Category 887
889	\N	Category 888
890	\N	Category 889
891	\N	Category 890
892	\N	Category 891
893	\N	Category 892
894	\N	Category 893
895	\N	Category 894
896	\N	Category 895
897	\N	Category 896
898	\N	Category 897
899	\N	Category 898
900	\N	Category 899
901	\N	Category 900
902	\N	Category 901
903	\N	Category 902
904	\N	Category 903
905	\N	Category 904
906	\N	Category 905
907	\N	Category 906
908	\N	Category 907
909	\N	Category 908
910	\N	Category 909
911	\N	Category 910
912	\N	Category 911
913	\N	Category 912
914	\N	Category 913
915	\N	Category 914
916	\N	Category 915
917	\N	Category 916
918	\N	Category 917
919	\N	Category 918
920	\N	Category 919
921	\N	Category 920
922	\N	Category 921
923	\N	Category 922
924	\N	Category 923
925	\N	Category 924
926	\N	Category 925
927	\N	Category 926
928	\N	Category 927
929	\N	Category 928
930	\N	Category 929
931	\N	Category 930
932	\N	Category 931
933	\N	Category 932
934	\N	Category 933
935	\N	Category 934
936	\N	Category 935
937	\N	Category 936
938	\N	Category 937
939	\N	Category 938
940	\N	Category 939
941	\N	Category 940
942	\N	Category 941
943	\N	Category 942
944	\N	Category 943
945	\N	Category 944
946	\N	Category 945
947	\N	Category 946
948	\N	Category 947
949	\N	Category 948
950	\N	Category 949
951	\N	Category 950
952	\N	Category 951
953	\N	Category 952
954	\N	Category 953
955	\N	Category 954
956	\N	Category 955
957	\N	Category 956
958	\N	Category 957
959	\N	Category 958
960	\N	Category 959
961	\N	Category 960
962	\N	Category 961
963	\N	Category 962
964	\N	Category 963
965	\N	Category 964
966	\N	Category 965
967	\N	Category 966
968	\N	Category 967
969	\N	Category 968
970	\N	Category 969
971	\N	Category 970
972	\N	Category 971
973	\N	Category 972
974	\N	Category 973
975	\N	Category 974
976	\N	Category 975
977	\N	Category 976
978	\N	Category 977
979	\N	Category 978
980	\N	Category 979
981	\N	Category 980
982	\N	Category 981
983	\N	Category 982
984	\N	Category 983
985	\N	Category 984
986	\N	Category 985
987	\N	Category 986
988	\N	Category 987
989	\N	Category 988
990	\N	Category 989
991	\N	Category 990
992	\N	Category 991
993	\N	Category 992
994	\N	Category 993
995	\N	Category 994
996	\N	Category 995
997	\N	Category 996
998	\N	Category 997
999	\N	Category 998
1000	\N	Category 999
1001	\N	Category 0
1002	\N	Category 1
1003	\N	Category 2
1004	\N	Category 3
1005	\N	Category 4
1006	\N	Category 5
1007	\N	Category 6
1008	\N	Category 7
1009	\N	Category 8
1010	\N	Category 9
1011	\N	Category 10
1012	\N	Category 11
1013	\N	Category 12
1014	\N	Category 13
1015	\N	Category 14
1016	\N	Category 15
1017	\N	Category 16
1018	\N	Category 17
1019	\N	Category 18
1020	\N	Category 19
1021	\N	Category 20
1022	\N	Category 21
1023	\N	Category 22
1024	\N	Category 23
1025	\N	Category 24
1026	\N	Category 25
1027	\N	Category 26
1028	\N	Category 27
1029	\N	Category 28
1030	\N	Category 29
1031	\N	Category 30
1032	\N	Category 31
1033	\N	Category 32
1034	\N	Category 33
1035	\N	Category 34
1036	\N	Category 35
1037	\N	Category 36
1038	\N	Category 37
1039	\N	Category 38
1040	\N	Category 39
1041	\N	Category 40
1042	\N	Category 41
1043	\N	Category 42
1044	\N	Category 43
1045	\N	Category 44
1046	\N	Category 45
1047	\N	Category 46
1048	\N	Category 47
1049	\N	Category 48
1050	\N	Category 49
1051	\N	Category 50
1052	\N	Category 51
1053	\N	Category 52
1054	\N	Category 53
1055	\N	Category 54
1056	\N	Category 55
1057	\N	Category 56
1058	\N	Category 57
1059	\N	Category 58
1060	\N	Category 59
1061	\N	Category 60
1062	\N	Category 61
1063	\N	Category 62
1064	\N	Category 63
1065	\N	Category 64
1066	\N	Category 65
1067	\N	Category 66
1068	\N	Category 67
1069	\N	Category 68
1070	\N	Category 69
1071	\N	Category 70
1072	\N	Category 71
1073	\N	Category 72
1074	\N	Category 73
1075	\N	Category 74
1076	\N	Category 75
1077	\N	Category 76
1078	\N	Category 77
1079	\N	Category 78
1080	\N	Category 79
1081	\N	Category 80
1082	\N	Category 81
1083	\N	Category 82
1084	\N	Category 83
1085	\N	Category 84
1086	\N	Category 85
1087	\N	Category 86
1088	\N	Category 87
1089	\N	Category 88
1090	\N	Category 89
1091	\N	Category 90
1092	\N	Category 91
1093	\N	Category 92
1094	\N	Category 93
1095	\N	Category 94
1096	\N	Category 95
1097	\N	Category 96
1098	\N	Category 97
1099	\N	Category 98
1100	\N	Category 99
1101	\N	Category 100
1102	\N	Category 101
1103	\N	Category 102
1104	\N	Category 103
1105	\N	Category 104
1106	\N	Category 105
1107	\N	Category 106
1108	\N	Category 107
1109	\N	Category 108
1110	\N	Category 109
1111	\N	Category 110
1112	\N	Category 111
1113	\N	Category 112
1114	\N	Category 113
1115	\N	Category 114
1116	\N	Category 115
1117	\N	Category 116
1118	\N	Category 117
1119	\N	Category 118
1120	\N	Category 119
1121	\N	Category 120
1122	\N	Category 121
1123	\N	Category 122
1124	\N	Category 123
1125	\N	Category 124
1126	\N	Category 125
1127	\N	Category 126
1128	\N	Category 127
1129	\N	Category 128
1130	\N	Category 129
1131	\N	Category 130
1132	\N	Category 131
1133	\N	Category 132
1134	\N	Category 133
1135	\N	Category 134
1136	\N	Category 135
1137	\N	Category 136
1138	\N	Category 137
1139	\N	Category 138
1140	\N	Category 139
1141	\N	Category 140
1142	\N	Category 141
1143	\N	Category 142
1144	\N	Category 143
1145	\N	Category 144
1146	\N	Category 145
1147	\N	Category 146
1148	\N	Category 147
1149	\N	Category 148
1150	\N	Category 149
1151	\N	Category 150
1152	\N	Category 151
1153	\N	Category 152
1154	\N	Category 153
1155	\N	Category 154
1156	\N	Category 155
1157	\N	Category 156
1158	\N	Category 157
1159	\N	Category 158
1160	\N	Category 159
1161	\N	Category 160
1162	\N	Category 161
1163	\N	Category 162
1164	\N	Category 163
1165	\N	Category 164
1166	\N	Category 165
1167	\N	Category 166
1168	\N	Category 167
1169	\N	Category 168
1170	\N	Category 169
1171	\N	Category 170
1172	\N	Category 171
1173	\N	Category 172
1174	\N	Category 173
1175	\N	Category 174
1176	\N	Category 175
1177	\N	Category 176
1178	\N	Category 177
1179	\N	Category 178
1180	\N	Category 179
1181	\N	Category 180
1182	\N	Category 181
1183	\N	Category 182
1184	\N	Category 183
1185	\N	Category 184
1186	\N	Category 185
1187	\N	Category 186
1188	\N	Category 187
1189	\N	Category 188
1190	\N	Category 189
1191	\N	Category 190
1192	\N	Category 191
1193	\N	Category 192
1194	\N	Category 193
1195	\N	Category 194
1196	\N	Category 195
1197	\N	Category 196
1198	\N	Category 197
1199	\N	Category 198
1200	\N	Category 199
1201	\N	Category 200
1202	\N	Category 201
1203	\N	Category 202
1204	\N	Category 203
1205	\N	Category 204
1206	\N	Category 205
1207	\N	Category 206
1208	\N	Category 207
1209	\N	Category 208
1210	\N	Category 209
1211	\N	Category 210
1212	\N	Category 211
1213	\N	Category 212
1214	\N	Category 213
1215	\N	Category 214
1216	\N	Category 215
1217	\N	Category 216
1218	\N	Category 217
1219	\N	Category 218
1220	\N	Category 219
1221	\N	Category 220
1222	\N	Category 221
1223	\N	Category 222
1224	\N	Category 223
1225	\N	Category 224
1226	\N	Category 225
1227	\N	Category 226
1228	\N	Category 227
1229	\N	Category 228
1230	\N	Category 229
1231	\N	Category 230
1232	\N	Category 231
1233	\N	Category 232
1234	\N	Category 233
1235	\N	Category 234
1236	\N	Category 235
1237	\N	Category 236
1238	\N	Category 237
1239	\N	Category 238
1240	\N	Category 239
1241	\N	Category 240
1242	\N	Category 241
1243	\N	Category 242
1244	\N	Category 243
1245	\N	Category 244
1246	\N	Category 245
1247	\N	Category 246
1248	\N	Category 247
1249	\N	Category 248
1250	\N	Category 249
1251	\N	Category 250
1252	\N	Category 251
1253	\N	Category 252
1254	\N	Category 253
1255	\N	Category 254
1256	\N	Category 255
1257	\N	Category 256
1258	\N	Category 257
1259	\N	Category 258
1260	\N	Category 259
1261	\N	Category 260
1262	\N	Category 261
1263	\N	Category 262
1264	\N	Category 263
1265	\N	Category 264
1266	\N	Category 265
1267	\N	Category 266
1268	\N	Category 267
1269	\N	Category 268
1270	\N	Category 269
1271	\N	Category 270
1272	\N	Category 271
1273	\N	Category 272
1274	\N	Category 273
1275	\N	Category 274
1276	\N	Category 275
1277	\N	Category 276
1278	\N	Category 277
1279	\N	Category 278
1280	\N	Category 279
1281	\N	Category 280
1282	\N	Category 281
1283	\N	Category 282
1284	\N	Category 283
1285	\N	Category 284
1286	\N	Category 285
1287	\N	Category 286
1288	\N	Category 287
1289	\N	Category 288
1290	\N	Category 289
1291	\N	Category 290
1292	\N	Category 291
1293	\N	Category 292
1294	\N	Category 293
1295	\N	Category 294
1296	\N	Category 295
1297	\N	Category 296
1298	\N	Category 297
1299	\N	Category 298
1300	\N	Category 299
1301	\N	Category 300
1302	\N	Category 301
1303	\N	Category 302
1304	\N	Category 303
1305	\N	Category 304
1306	\N	Category 305
1307	\N	Category 306
1308	\N	Category 307
1309	\N	Category 308
1310	\N	Category 309
1311	\N	Category 310
1312	\N	Category 311
1313	\N	Category 312
1314	\N	Category 313
1315	\N	Category 314
1316	\N	Category 315
1317	\N	Category 316
1318	\N	Category 317
1319	\N	Category 318
1320	\N	Category 319
1321	\N	Category 320
1322	\N	Category 321
1323	\N	Category 322
1324	\N	Category 323
1325	\N	Category 324
1326	\N	Category 325
1327	\N	Category 326
1328	\N	Category 327
1329	\N	Category 328
1330	\N	Category 329
1331	\N	Category 330
1332	\N	Category 331
1333	\N	Category 332
1334	\N	Category 333
1335	\N	Category 334
1336	\N	Category 335
1337	\N	Category 336
1338	\N	Category 337
1339	\N	Category 338
1340	\N	Category 339
1341	\N	Category 340
1342	\N	Category 341
1343	\N	Category 342
1344	\N	Category 343
1345	\N	Category 344
1346	\N	Category 345
1347	\N	Category 346
1348	\N	Category 347
1349	\N	Category 348
1350	\N	Category 349
1351	\N	Category 350
1352	\N	Category 351
1353	\N	Category 352
1354	\N	Category 353
1355	\N	Category 354
1356	\N	Category 355
1357	\N	Category 356
1358	\N	Category 357
1359	\N	Category 358
1360	\N	Category 359
1361	\N	Category 360
1362	\N	Category 361
1363	\N	Category 362
1364	\N	Category 363
1365	\N	Category 364
1366	\N	Category 365
1367	\N	Category 366
1368	\N	Category 367
1369	\N	Category 368
1370	\N	Category 369
1371	\N	Category 370
1372	\N	Category 371
1373	\N	Category 372
1374	\N	Category 373
1375	\N	Category 374
1376	\N	Category 375
1377	\N	Category 376
1378	\N	Category 377
1379	\N	Category 378
1380	\N	Category 379
1381	\N	Category 380
1382	\N	Category 381
1383	\N	Category 382
1384	\N	Category 383
1385	\N	Category 384
1386	\N	Category 385
1387	\N	Category 386
1388	\N	Category 387
1389	\N	Category 388
1390	\N	Category 389
1391	\N	Category 390
1392	\N	Category 391
1393	\N	Category 392
1394	\N	Category 393
1395	\N	Category 394
1396	\N	Category 395
1397	\N	Category 396
1398	\N	Category 397
1399	\N	Category 398
1400	\N	Category 399
1401	\N	Category 400
1402	\N	Category 401
1403	\N	Category 402
1404	\N	Category 403
1405	\N	Category 404
1406	\N	Category 405
1407	\N	Category 406
1408	\N	Category 407
1409	\N	Category 408
1410	\N	Category 409
1411	\N	Category 410
1412	\N	Category 411
1413	\N	Category 412
1414	\N	Category 413
1415	\N	Category 414
1416	\N	Category 415
1417	\N	Category 416
1418	\N	Category 417
1419	\N	Category 418
1420	\N	Category 419
1421	\N	Category 420
1422	\N	Category 421
1423	\N	Category 422
1424	\N	Category 423
1425	\N	Category 424
1426	\N	Category 425
1427	\N	Category 426
1428	\N	Category 427
1429	\N	Category 428
1430	\N	Category 429
1431	\N	Category 430
1432	\N	Category 431
1433	\N	Category 432
1434	\N	Category 433
1435	\N	Category 434
1436	\N	Category 435
1437	\N	Category 436
1438	\N	Category 437
1439	\N	Category 438
1440	\N	Category 439
1441	\N	Category 440
1442	\N	Category 441
1443	\N	Category 442
1444	\N	Category 443
1445	\N	Category 444
1446	\N	Category 445
1447	\N	Category 446
1448	\N	Category 447
1449	\N	Category 448
1450	\N	Category 449
1451	\N	Category 450
1452	\N	Category 451
1453	\N	Category 452
1454	\N	Category 453
1455	\N	Category 454
1456	\N	Category 455
1457	\N	Category 456
1458	\N	Category 457
1459	\N	Category 458
1460	\N	Category 459
1461	\N	Category 460
1462	\N	Category 461
1463	\N	Category 462
1464	\N	Category 463
1465	\N	Category 464
1466	\N	Category 465
1467	\N	Category 466
1468	\N	Category 467
1469	\N	Category 468
1470	\N	Category 469
1471	\N	Category 470
1472	\N	Category 471
1473	\N	Category 472
1474	\N	Category 473
1475	\N	Category 474
1476	\N	Category 475
1477	\N	Category 476
1478	\N	Category 477
1479	\N	Category 478
1480	\N	Category 479
1481	\N	Category 480
1482	\N	Category 481
1483	\N	Category 482
1484	\N	Category 483
1485	\N	Category 484
1486	\N	Category 485
1487	\N	Category 486
1488	\N	Category 487
1489	\N	Category 488
1490	\N	Category 489
1491	\N	Category 490
1492	\N	Category 491
1493	\N	Category 492
1494	\N	Category 493
1495	\N	Category 494
1496	\N	Category 495
1497	\N	Category 496
1498	\N	Category 497
1499	\N	Category 498
1500	\N	Category 499
1501	\N	Category 500
1502	\N	Category 501
1503	\N	Category 502
1504	\N	Category 503
1505	\N	Category 504
1506	\N	Category 505
1507	\N	Category 506
1508	\N	Category 507
1509	\N	Category 508
1510	\N	Category 509
1511	\N	Category 510
1512	\N	Category 511
1513	\N	Category 512
1514	\N	Category 513
1515	\N	Category 514
1516	\N	Category 515
1517	\N	Category 516
1518	\N	Category 517
1519	\N	Category 518
1520	\N	Category 519
1521	\N	Category 520
1522	\N	Category 521
1523	\N	Category 522
1524	\N	Category 523
1525	\N	Category 524
1526	\N	Category 525
1527	\N	Category 526
1528	\N	Category 527
1529	\N	Category 528
1530	\N	Category 529
1531	\N	Category 530
1532	\N	Category 531
1533	\N	Category 532
1534	\N	Category 533
1535	\N	Category 534
1536	\N	Category 535
1537	\N	Category 536
1538	\N	Category 537
1539	\N	Category 538
1540	\N	Category 539
1541	\N	Category 540
1542	\N	Category 541
1543	\N	Category 542
1544	\N	Category 543
1545	\N	Category 544
1546	\N	Category 545
1547	\N	Category 546
1548	\N	Category 547
1549	\N	Category 548
1550	\N	Category 549
1551	\N	Category 550
1552	\N	Category 551
1553	\N	Category 552
1554	\N	Category 553
1555	\N	Category 554
1556	\N	Category 555
1557	\N	Category 556
1558	\N	Category 557
1559	\N	Category 558
1560	\N	Category 559
1561	\N	Category 560
1562	\N	Category 561
1563	\N	Category 562
1564	\N	Category 563
1565	\N	Category 564
1566	\N	Category 565
1567	\N	Category 566
1568	\N	Category 567
1569	\N	Category 568
1570	\N	Category 569
1571	\N	Category 570
1572	\N	Category 571
1573	\N	Category 572
1574	\N	Category 573
1575	\N	Category 574
1576	\N	Category 575
1577	\N	Category 576
1578	\N	Category 577
1579	\N	Category 578
1580	\N	Category 579
1581	\N	Category 580
1582	\N	Category 581
1583	\N	Category 582
1584	\N	Category 583
1585	\N	Category 584
1586	\N	Category 585
1587	\N	Category 586
1588	\N	Category 587
1589	\N	Category 588
1590	\N	Category 589
1591	\N	Category 590
1592	\N	Category 591
1593	\N	Category 592
1594	\N	Category 593
1595	\N	Category 594
1596	\N	Category 595
1597	\N	Category 596
1598	\N	Category 597
1599	\N	Category 598
1600	\N	Category 599
1601	\N	Category 600
1602	\N	Category 601
1603	\N	Category 602
1604	\N	Category 603
1605	\N	Category 604
1606	\N	Category 605
1607	\N	Category 606
1608	\N	Category 607
1609	\N	Category 608
1610	\N	Category 609
1611	\N	Category 610
1612	\N	Category 611
1613	\N	Category 612
1614	\N	Category 613
1615	\N	Category 614
1616	\N	Category 615
1617	\N	Category 616
1618	\N	Category 617
1619	\N	Category 618
1620	\N	Category 619
1621	\N	Category 620
1622	\N	Category 621
1623	\N	Category 622
1624	\N	Category 623
1625	\N	Category 624
1626	\N	Category 625
1627	\N	Category 626
1628	\N	Category 627
1629	\N	Category 628
1630	\N	Category 629
1631	\N	Category 630
1632	\N	Category 631
1633	\N	Category 632
1634	\N	Category 633
1635	\N	Category 634
1636	\N	Category 635
1637	\N	Category 636
1638	\N	Category 637
1639	\N	Category 638
1640	\N	Category 639
1641	\N	Category 640
1642	\N	Category 641
1643	\N	Category 642
1644	\N	Category 643
1645	\N	Category 644
1646	\N	Category 645
1647	\N	Category 646
1648	\N	Category 647
1649	\N	Category 648
1650	\N	Category 649
1651	\N	Category 650
1652	\N	Category 651
1653	\N	Category 652
1654	\N	Category 653
1655	\N	Category 654
1656	\N	Category 655
1657	\N	Category 656
1658	\N	Category 657
1659	\N	Category 658
1660	\N	Category 659
1661	\N	Category 660
1662	\N	Category 661
1663	\N	Category 662
1664	\N	Category 663
1665	\N	Category 664
1666	\N	Category 665
1667	\N	Category 666
1668	\N	Category 667
1669	\N	Category 668
1670	\N	Category 669
1671	\N	Category 670
1672	\N	Category 671
1673	\N	Category 672
1674	\N	Category 673
1675	\N	Category 674
1676	\N	Category 675
1677	\N	Category 676
1678	\N	Category 677
1679	\N	Category 678
1680	\N	Category 679
1681	\N	Category 680
1682	\N	Category 681
1683	\N	Category 682
1684	\N	Category 683
1685	\N	Category 684
1686	\N	Category 685
1687	\N	Category 686
1688	\N	Category 687
1689	\N	Category 688
1690	\N	Category 689
1691	\N	Category 690
1692	\N	Category 691
1693	\N	Category 692
1694	\N	Category 693
1695	\N	Category 694
1696	\N	Category 695
1697	\N	Category 696
1698	\N	Category 697
1699	\N	Category 698
1700	\N	Category 699
1701	\N	Category 700
1702	\N	Category 701
1703	\N	Category 702
1704	\N	Category 703
1705	\N	Category 704
1706	\N	Category 705
1707	\N	Category 706
1708	\N	Category 707
1709	\N	Category 708
1710	\N	Category 709
1711	\N	Category 710
1712	\N	Category 711
1713	\N	Category 712
1714	\N	Category 713
1715	\N	Category 714
1716	\N	Category 715
1717	\N	Category 716
1718	\N	Category 717
1719	\N	Category 718
1720	\N	Category 719
1721	\N	Category 720
1722	\N	Category 721
1723	\N	Category 722
1724	\N	Category 723
1725	\N	Category 724
1726	\N	Category 725
1727	\N	Category 726
1728	\N	Category 727
1729	\N	Category 728
1730	\N	Category 729
1731	\N	Category 730
1732	\N	Category 731
1733	\N	Category 732
1734	\N	Category 733
1735	\N	Category 734
1736	\N	Category 735
1737	\N	Category 736
1738	\N	Category 737
1739	\N	Category 738
1740	\N	Category 739
1741	\N	Category 740
1742	\N	Category 741
1743	\N	Category 742
1744	\N	Category 743
1745	\N	Category 744
1746	\N	Category 745
1747	\N	Category 746
1748	\N	Category 747
1749	\N	Category 748
1750	\N	Category 749
1751	\N	Category 750
1752	\N	Category 751
1753	\N	Category 752
1754	\N	Category 753
1755	\N	Category 754
1756	\N	Category 755
1757	\N	Category 756
1758	\N	Category 757
1759	\N	Category 758
1760	\N	Category 759
1761	\N	Category 760
1762	\N	Category 761
1763	\N	Category 762
1764	\N	Category 763
1765	\N	Category 764
1766	\N	Category 765
1767	\N	Category 766
1768	\N	Category 767
1769	\N	Category 768
1770	\N	Category 769
1771	\N	Category 770
1772	\N	Category 771
1773	\N	Category 772
1774	\N	Category 773
1775	\N	Category 774
1776	\N	Category 775
1777	\N	Category 776
1778	\N	Category 777
1779	\N	Category 778
1780	\N	Category 779
1781	\N	Category 780
1782	\N	Category 781
1783	\N	Category 782
1784	\N	Category 783
1785	\N	Category 784
1786	\N	Category 785
1787	\N	Category 786
1788	\N	Category 787
1789	\N	Category 788
1790	\N	Category 789
1791	\N	Category 790
1792	\N	Category 791
1793	\N	Category 792
1794	\N	Category 793
1795	\N	Category 794
1796	\N	Category 795
1797	\N	Category 796
1798	\N	Category 797
1799	\N	Category 798
1800	\N	Category 799
1801	\N	Category 800
1802	\N	Category 801
1803	\N	Category 802
1804	\N	Category 803
1805	\N	Category 804
1806	\N	Category 805
1807	\N	Category 806
1808	\N	Category 807
1809	\N	Category 808
1810	\N	Category 809
1811	\N	Category 810
1812	\N	Category 811
1813	\N	Category 812
1814	\N	Category 813
1815	\N	Category 814
1816	\N	Category 815
1817	\N	Category 816
1818	\N	Category 817
1819	\N	Category 818
1820	\N	Category 819
1821	\N	Category 820
1822	\N	Category 821
1823	\N	Category 822
1824	\N	Category 823
1825	\N	Category 824
1826	\N	Category 825
1827	\N	Category 826
1828	\N	Category 827
1829	\N	Category 828
1830	\N	Category 829
1831	\N	Category 830
1832	\N	Category 831
1833	\N	Category 832
1834	\N	Category 833
1835	\N	Category 834
1836	\N	Category 835
1837	\N	Category 836
1838	\N	Category 837
1839	\N	Category 838
1840	\N	Category 839
1841	\N	Category 840
1842	\N	Category 841
1843	\N	Category 842
1844	\N	Category 843
1845	\N	Category 844
1846	\N	Category 845
1847	\N	Category 846
1848	\N	Category 847
1849	\N	Category 848
1850	\N	Category 849
1851	\N	Category 850
1852	\N	Category 851
1853	\N	Category 852
1854	\N	Category 853
1855	\N	Category 854
1856	\N	Category 855
1857	\N	Category 856
1858	\N	Category 857
1859	\N	Category 858
1860	\N	Category 859
1861	\N	Category 860
1862	\N	Category 861
1863	\N	Category 862
1864	\N	Category 863
1865	\N	Category 864
1866	\N	Category 865
1867	\N	Category 866
1868	\N	Category 867
1869	\N	Category 868
1870	\N	Category 869
1871	\N	Category 870
1872	\N	Category 871
1873	\N	Category 872
1874	\N	Category 873
1875	\N	Category 874
1876	\N	Category 875
1877	\N	Category 876
1878	\N	Category 877
1879	\N	Category 878
1880	\N	Category 879
1881	\N	Category 880
1882	\N	Category 881
1883	\N	Category 882
1884	\N	Category 883
1885	\N	Category 884
1886	\N	Category 885
1887	\N	Category 886
1888	\N	Category 887
1889	\N	Category 888
1890	\N	Category 889
1891	\N	Category 890
1892	\N	Category 891
1893	\N	Category 892
1894	\N	Category 893
1895	\N	Category 894
1896	\N	Category 895
1897	\N	Category 896
1898	\N	Category 897
1899	\N	Category 898
1900	\N	Category 899
1901	\N	Category 900
1902	\N	Category 901
1903	\N	Category 902
1904	\N	Category 903
1905	\N	Category 904
1906	\N	Category 905
1907	\N	Category 906
1908	\N	Category 907
1909	\N	Category 908
1910	\N	Category 909
1911	\N	Category 910
1912	\N	Category 911
1913	\N	Category 912
1914	\N	Category 913
1915	\N	Category 914
1916	\N	Category 915
1917	\N	Category 916
1918	\N	Category 917
1919	\N	Category 918
1920	\N	Category 919
1921	\N	Category 920
1922	\N	Category 921
1923	\N	Category 922
1924	\N	Category 923
1925	\N	Category 924
1926	\N	Category 925
1927	\N	Category 926
1928	\N	Category 927
1929	\N	Category 928
1930	\N	Category 929
1931	\N	Category 930
1932	\N	Category 931
1933	\N	Category 932
1934	\N	Category 933
1935	\N	Category 934
1936	\N	Category 935
1937	\N	Category 936
1938	\N	Category 937
1939	\N	Category 938
1940	\N	Category 939
1941	\N	Category 940
1942	\N	Category 941
1943	\N	Category 942
1944	\N	Category 943
1945	\N	Category 944
1946	\N	Category 945
1947	\N	Category 946
1948	\N	Category 947
1949	\N	Category 948
1950	\N	Category 949
1951	\N	Category 950
1952	\N	Category 951
1953	\N	Category 952
1954	\N	Category 953
1955	\N	Category 954
1956	\N	Category 955
1957	\N	Category 956
1958	\N	Category 957
1959	\N	Category 958
1960	\N	Category 959
1961	\N	Category 960
1962	\N	Category 961
1963	\N	Category 962
1964	\N	Category 963
1965	\N	Category 964
1966	\N	Category 965
1967	\N	Category 966
1968	\N	Category 967
1969	\N	Category 968
1970	\N	Category 969
1971	\N	Category 970
1972	\N	Category 971
1973	\N	Category 972
1974	\N	Category 973
1975	\N	Category 974
1976	\N	Category 975
1977	\N	Category 976
1978	\N	Category 977
1979	\N	Category 978
1980	\N	Category 979
1981	\N	Category 980
1982	\N	Category 981
1983	\N	Category 982
1984	\N	Category 983
1985	\N	Category 984
1986	\N	Category 985
1987	\N	Category 986
1988	\N	Category 987
1989	\N	Category 988
1990	\N	Category 989
1991	\N	Category 990
1992	\N	Category 991
1993	\N	Category 992
1994	\N	Category 993
1995	\N	Category 994
1996	\N	Category 995
1997	\N	Category 996
1998	\N	Category 997
1999	\N	Category 998
2000	\N	Category 999
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.payments (payment_id, user_id, payment_date, amount) FROM stdin;
\.


--
-- Data for Name: price_change; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.price_change (change_id, product_id, date_price_change, new_price) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.product (product_id, product_name, path_to_file, description, is_active, data_product_create) FROM stdin;
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.product_category (product_id, category_id) FROM stdin;
\.


--
-- Data for Name: purchase; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.purchase (purchase_id, purchase_date, customer_id, product_id, product_price) FROM stdin;
\.


--
-- Data for Name: user_service; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_service (user_id, email, password_hash, balance) FROM stdin;
\.


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.category_category_id_seq', 2000, true);


--
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 1, false);


--
-- Name: price_change_change_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.price_change_change_id_seq', 1, false);


--
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.product_product_id_seq', 1, false);


--
-- Name: purchase_purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.purchase_purchase_id_seq', 1, false);


--
-- Name: user_service_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_service_user_id_seq', 1, false);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: price_change price_change_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.price_change
    ADD CONSTRAINT price_change_pkey PRIMARY KEY (change_id);


--
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (product_id, category_id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- Name: purchase purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (purchase_id);


--
-- Name: user_service user_service_email_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_service
    ADD CONSTRAINT user_service_email_key UNIQUE (email);


--
-- Name: user_service user_service_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_service
    ADD CONSTRAINT user_service_pkey PRIMARY KEY (user_id);


--
-- Name: category category_parent_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_parent_category_fkey FOREIGN KEY (parent_category) REFERENCES public.category(category_id);


--
-- Name: payments payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_service(user_id);


--
-- Name: price_change price_change_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.price_change
    ADD CONSTRAINT price_change_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- Name: product_category product_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id);


--
-- Name: product_category product_category_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- Name: purchase purchase_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.user_service(user_id);


--
-- Name: purchase purchase_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- PostgreSQL database dump complete
--

