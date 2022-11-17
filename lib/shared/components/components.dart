import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit2/cubit.dart';
import 'package:news_app/shared/cubit2/states.dart';

buildArticleItem(article, context) => BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: article['urlToImage'] == null
                          ? const NetworkImage(
                              'https://media.wired.com/photos/5b17381815b2c744cb650b5f/master/pass/GettyImages-134367495.jpg')
                          : NetworkImage('${article['urlToImage']}'),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SizedBox(
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            '${article['title']}',
                            style: AppCubit.get(context).isDark
                                ? Theme.of(context).textTheme.bodyText1
                                : Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Text(
                          '${article['publishedAt']}',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );

myDivider() => Container(height: 1, width: double.infinity, color: Colors.grey);

articleBuilder(cubit) => ConditionalBuilder(
      condition: cubit.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>
            buildArticleItem(cubit[index], context),
        separatorBuilder: (BuildContext context, int index) => myDivider(),
        itemCount: cubit.length,
      ),
      fallback: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

defaultFormField({
  @required TextEditingController? controller,
  @required TextInputType? keyboard,
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  @required String? Function(String?)? validator,
  @required String? text,
  @required IconData? prefixIcon,
  IconData? suffixIcon,
  bool isPassword = false,
  VoidCallback? iconSuffix,
  VoidCallback? onTap,
}) =>
    TextFormField(
      onTap: onTap,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: text!,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon!),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: iconSuffix,
                icon: isPassword
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.remove_red_eye),
              )
            : null,
      ),
      keyboardType: keyboard,
      obscureText: isPassword,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
    );
